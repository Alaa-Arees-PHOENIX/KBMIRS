from clips import Environment

env = Environment()

env.load ("instruments_data.clp")
env.load ("user.clp")
env.load ("knowledge_base.clp")

env.reset()

env.run()

for fact in env.facts():
    if fact.template.name == 'musical_instrument':
        print (fact['name'])
