
 #This is the javascript specific to the minimal4e DST
 # In this example, we're using some javascript to update the ability modifiers when someone changes their
 # level or their ability score.
 #
 # The key is to use the callback functions to catch the right events.
 # Read the top comments in characters.js to get a better idea of how the callbacks work.
 #
 # Copy and paste this directly into the javascript textarea on obsidianportal.com
$ = jQuery

window.fate_core_dataPreLoad = (options) ->
  # Called just before the data is loaded.
  #alert("dataPreLoad")

window.fate_core_dataPostLoad = (options) ->
  # Called just after the data is loaded.
  #alert("dataPostLoad")
  fate_core_process_skills()

window.fate_core_dataChange = (options) ->
  # Called immediately after a data value is changed.
  # alert("dataChange. " + options['fieldName'] + " = " + options['fieldValue'])

window.fate_core_dataPreSave = (options) ->
  # Called just before the data is saved to the server.
  # alert("dataPreSave")

# You can define your own variables...just make sure to namespace them!

window.fate_core_trim_skill_name = (name) ->
  name.replace(/^(\s*)'|'(\s*)$/g, '')

window.fate_core_skill_html = (skill) ->
  '<li>' + skill + '</li>'

window.fate_core_set_skill_html = (index, skill_container) ->
  console.log 'inside'
  console.log skill_container
  console.log skill_container.textContent
  console.log skill_container.textContent.split(',')
  console.log skill_container.textContent.split(',').map(fate_core_trim_skill_name)
  console.log 'before skills'
  skills = skill_container.textContent.split(',').map(fate_core_trim_skill_name)
  console.log 'after skills'
  console.log skills
  return true if skills.length < 2 and skills[0].length == 0
  html = '<ul>' + skills.map(fate_core_skill_html).join('') + '</ul>'
  console.log 'html'
  console.log html
  skill_container.innerHTML = html
  console.log(skills)

window.fate_core_process_skills = ->
  skill_containers = $('.skills').children().children('.dsf')
  console.log skill_containers
  $.each(skill_containers, fate_core_set_skill_html)
  
  skill_containers

