
 #This is the javascript specific to the minimal4e DST
 # In this example, we're using some javascript to update the ability modifiers when someone changes their
 # level or their ability score.
 #
 # The key is to use the callback functions to catch the right events.
 # Read the top comments in characters.js to get a better idea of how the callbacks work.
 #
 # Copy and paste this directly into the javascript textarea on obsidianportal.com
$ = jQuery

fate_core_dataPreLoad: (options) ->
  # Called just before the data is loaded.
  alert("dataPreLoad")

fate_core_dataPostLoad: (options) ->
  # Called just after the data is loaded.
  alert("dataPostLoad")
  fate_core_process_skills

fate_core_dataChange: (options) ->
  # Called immediately after a data value is changed.
  # alert("dataChange. " + options['fieldName'] + " = " + options['fieldValue'])

fate_core_dataPreSave: (options) ->
  # Called just before the data is saved to the server.
  # alert("dataPreSave")

# You can define your own variables...just make sure to namespace them!

fate_core_trim_skill_name: (name) ->
  name.replace(/^(\s*)'|'(\s*)$/g, '')

fate_core_skill_html: (skill) ->
  '<li>' + skill + '</li>'

fate_core_process_skills: ->
  skill_containers = $('.skills').children().children('.dsf')
  skill_container = skill_containers.first()
  skills = skill_container.text().split(',').map(fate_core_trim_skill_name)
  html = '<ul>' + skills.map(fate_core_skill_html).join('') + '</ul>'
  
  console.log(skills)
  skill_container.html(html)

