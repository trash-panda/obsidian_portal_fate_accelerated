
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
  fate_core_set_placeholder()

window.fate_core_dataPostLoad = (options) ->
  # Called just after the data is loaded.
  fate_core_mark_used_skills()
  fate_core_set_active_stress()

window.fate_core_dataChange = (options) ->
  # Called immediately after a data value is changed.
  fate_core_update_skill(options)
  fate_core_update_active_stress(options)

window.fate_core_dataPreSave = (options) ->
  # Called just before the data is saved to the server.
  # alert("dataPreSave")

# You can define your own variables...just make sure to namespace them!

window.fate_core_set_active_stress = () ->
  stresses = $('td.stress')
  for entry in stresses
    group = entry.children[0]
    activator = entry.children[1].children[0].children[0]
    if activator.value == '0'
      group.classList.add('inactive')
    else
      group.classList.add('active')

window.fate_core_set_placeholder = () ->
  aisleten.characters.jeditablePlaceholder = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"

window.fate_core_mark_used_skills = () ->
  listings = $('.skill.inactive')
  for listing in listings
    content = listing.childNodes[1].innerHTML.trim()
    if content.length > 0
      listing.className = 'skill'

window.fate_core_update_active_stress = (opts) ->
  name = opts['fieldName']
  value = opts['fieldValue']
  match = name.match(/(\w+)_stress_(\d\d)_active/)
  return unless match
  stress = $(".dsf_#{match[1]}_stress_#{match[2]}")
  if value == "1"
    stress.parent().addClass('active')
    stress.parent().removeClass('inactive')
  else
    stress.parent().addClass('inactive')
    stress.parent().removeClass('active')

window.fate_core_update_skill = (opts) ->
  name = opts['fieldName']
  value = opts['fieldValue']
  match = name.match(/skill_(\w+)_(\d\d)/)
  return unless  match
  skill = $(".dsf_#{name}").first()
  if skill.text() == aisleten.characters.jeditablePlaceholder or skill.text() == ''
    skill.parent().addClass 'inactive'
  else
    skill.parent().removeClass 'inactive'

