from clips import Environment
import tkinter as tk
from tkinter import ttk, messagebox

class MusicQuestionnaire:
    def __init__(self, root):
        self.env = Environment()

        self.env.load ("instruments_data.clp")
        self.env.load ("user.clp")
        self.env.load ("knowledge_base.clp")

        self.env.reset()

        self.root = root
        self.root.title("Music Preference Questionnaire")
        self.root.geometry("1366x768")
        self.root.resizable(True, True)
        
        # Dictionary to store all answers
        self.answers = {}
        
        # Create main frame with scrolling
        main_frame = tk.Frame(root)
        main_frame.pack(fill=tk.BOTH, expand=True, padx=20, pady=20)
        
        # Canvas and scrollbar for scrolling
        canvas = tk.Canvas(main_frame)
        scrollbar = tk.Scrollbar(main_frame, orient="vertical", command=canvas.yview)
        scrollable_frame = tk.Frame(canvas)
        
        scrollable_frame.bind(
            "<Configure>",
            lambda e: canvas.configure(scrollregion=canvas.bbox("all"))
        )
        
        canvas.create_window((0, 0), window=scrollable_frame, anchor="nw")
        canvas.configure(yscrollcommand=scrollbar.set)
        
        canvas.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")
        
        # Question 1: Musical style
        self.create_question(
            scrollable_frame, 1,
            "What musical style do you prefer listening to?",
            ["classic", "jazz", "rock", "folk"],
            "combobox"
        )
        
        # Question 2: Rhythm instrument
        self.create_question(
            scrollable_frame, 2,
            "Do you like percussion instruments?",
            [True, False],
            "radiobutton"
        )
        
        # Question 3: Financial capacity
        self.create_question(
            scrollable_frame, 3,
            "What is your financial capacity?",
            ["low", "medium", "high"],
            "combobox"
        )
        

        # Question 4: wind instrument
        self.create_question(
            scrollable_frame, 4,
            "Do you like wind instruments?",
            [True, False],
            "radiobutton"
        )

        # Question 5: Lungs capacity
        self.create_question(
            scrollable_frame, 5,
            "How do you describe your lungs capacity?",
            ["low", "high"],
            "combobox"
        )
        
        # Question 6: Create harmonies
        self.create_question(
            scrollable_frame, 6,
            "Do you want to create harmonies?",
            [True, False],
            "radiobutton"
        )
        
        # Question 7: Play with group
        self.create_question(
            scrollable_frame, 7,
            "Do you like to play with a group?",
            [True, False],
            "radiobutton"
        )
        
        # Question 8: Travel a lot
        self.create_question(
            scrollable_frame, 8,
            "Do you travel a lot?",
            [True, False],
            "radiobutton"
        )
        
        # Question 9: Years for training
        self.create_question(
            scrollable_frame, 9,
            "How you describe the period you have for training (to be professional)?",
            ["short", "medium", "long"],
            "combobox"
        )
        
        # Question 10: Complaining neighbors
        self.create_question(
            scrollable_frame, 10,
            "Do you have complaining neighbors?",
            [True, False],
            "radiobutton"
        )
        
        # Submit button
        submit_btn = tk.Button(
            scrollable_frame,
            text="Submit Answers",
            command=self.submit_answers,
            bg="#4CAF50",
            fg="white",
            font=("Arial", 12, "bold"),
            pady=10
        )
        submit_btn.pack(pady=20)
        
        # Bind mouse wheel for scrolling
        def on_mousewheel(event):
            canvas.yview_scroll(int(-1*(event.delta/120)), "units")
        
        canvas.bind_all("<MouseWheel>", on_mousewheel)
    
    def create_question(self, parent, q_num, question_text, options, widget_type):
        """Create a question frame with label and input widget"""
        frame = tk.Frame(parent)
        frame.pack(fill=tk.X, pady=10)
        
        # Question label
        label = tk.Label(
            frame,
            text=f"{q_num}. {question_text}",
            font=("Arial", 10, "bold"),
            wraplength=450,
            justify=tk.LEFT
        )
        label.pack(anchor=tk.W, pady=(0, 5))
        
        # Variable to store answer
        var = None
        
        if widget_type == "combobox":
            var = tk.StringVar()
            combo = ttk.Combobox(frame, textvariable=var, values=options, state="readonly")
            combo.pack(anchor=tk.W, padx=20)
            self.answers[q_num] = var
        
        elif widget_type == "radiobutton":
            var = tk.StringVar(value="")
            for option in options:
                rb = tk.Radiobutton(
                    frame,
                    text=str(option),
                    variable=var,
                    value=str(option),
                    font=("Arial", 9)
                )
                rb.pack(anchor=tk.W, padx=20)
            self.answers[q_num] = var
    
    def submit_answers(self):
        """Collect all answers and store them in variables"""
        # Check if all questions are answered
        all_answered = True
        for q_num, var in self.answers.items():
            if not var.get():
                all_answered = False
                messagebox.showwarning(
                    "Incomplete Questionnaire",
                    f"Please answer question {q_num} before submitting."
                )
                return
        
        # Store answers in variables
        preferred_music_style = self.answers[1].get()    
        like_percussion_instruments = self.answers[2].get() == "True" 
        budget = self.answers[3].get()     
        like_wind_instruments = self.answers[4].get() == "True"     
        lungs_capacity = self.answers[5].get() 
        enjoy_creating_harmonies = self.answers[6].get() == "True" 
        like_to_play_with_group = self.answers[7].get() == "True" 
        travels_alot = self.answers[8].get() == "True"  
        expected_time_of_training = self.answers[9].get()  
        complaining_neighbors = self.answers[10].get() == "True"
        # Display all answers in a message box
        result_message = f"""Your Answers:
        
1. Musical Style: {preferred_music_style}
2. Like Rhythm Instrument: {like_percussion_instruments}
3. Financial Capacity: {budget}
4. Like wind instrument: {like_wind_instruments}
5. Lungs Capacity: {lungs_capacity}
6. Want to Create Harmonies: {enjoy_creating_harmonies}
7. Like to Play with Group: {like_to_play_with_group}
8. Travel a Lot: {travels_alot}
9. Years for Training: {expected_time_of_training}
10. Have Complaining Neighbors: {complaining_neighbors}
        """
        
        messagebox.showinfo("Questionnaire Results", result_message)

        mapper = {'low':0, 'short':0, 'medium':1, 'high':2, 'long':2, True:'TRUE', False:'FALSE'}
        userAssertion = f"""(user
		(budget {mapper[budget]})
		(preferred_music_style {preferred_music_style})
        (like_wind_instruments {mapper[like_wind_instruments]})
		(like_percussion_instruments {mapper[like_percussion_instruments]})
		(travels_alot {mapper[travels_alot]})
		(complaining_neighbors {mapper[complaining_neighbors]})
		(lungs_capacity {lungs_capacity})
		(like_to_play_with_group {mapper[like_to_play_with_group]})
		(expected_time_of_training {mapper[expected_time_of_training]})
		(enjoy_creating_harmonies {mapper[enjoy_creating_harmonies]})
		)"""
        print (userAssertion)
        self.env.assert_string (userAssertion)
        self.env.run()

        print ("available instruments that you might like:")
        for fact in self.env.facts():
            if fact.template.name == 'musical_instrument':
                print (fact['name'])

        self.env.reset()
    
