
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

window.fate_core_dataPostLoad = (options) ->
  # Called just after the data is loaded.
  fate_core_mark_used_skills()
  fate_core_set_active_stress_boxes()
  fate_core_set_active_stress_tracks()
  fate_core_set_active_consequences()
  fate_core_set_active_stunts()
  fate_core_size_avatar()
  fate_core_size_points()
  fate_core_default_extra_consequences()
  fate_core_default_skill_names()
  fate_core_hide_last_table_row()
  fate_core_resize_name()

window.fate_core_dataChange = (options) ->
  # Called immediately after a data value is changed.
  fate_core_update_skill(options)
  fate_core_update_active_stress(options)
  fate_core_update_active_stress_tracks(options)
  fate_core_update_active_consequences(options)
  fate_core_update_active_stunts(options)
  fate_core_size_points()
  fate_core_default_extra_consequences()
  fate_core_default_skill_names()

window.fate_core_dataPreSave = (options) ->
  # Called just before the data is saved to the server.
  # alert("dataPreSave")

# You can define your own variables...just make sure to namespace them!

window.fate_core_hide_last_table_row = () ->
  $('table.stunts tr:visible:last').addClass('last_row')

window.fate_core_resize_name = () ->
  setTimeout ( ->
    name = $('.dsf_name')[0]
    size = 22
    name.style.fontSize = "#{size}px"
    while name.offsetWidth > 235
      size--
      name.style.fontSize = "#{size}px"
  ), 1000

window.fate_core_default_skill_names = () ->
  skills = $('.skill_name')
  for skill in skills
    if skill.innerHTML == aisleten.characters.jeditablePlaceholder or skill.innerHTML == ''
      if skill.classList.contains('dsf_skill_1_label')
        skill.innerHTML = 'Average (+1)'
      else if skill.classList.contains('dsf_skill_2_label')
        skill.innerHTML = 'Fair (+2)'
      else if skill.classList.contains('dsf_skill_3_label')
        skill.innerHTML = 'Good (+3)'
      else if skill.classList.contains('dsf_skill_4_label')
        skill.innerHTML = 'Great (+4)'
      else if skill.classList.contains('dsf_skill_5_label')
        skill.innerHTML = 'Superb (+5)'
      else if skill.classList.contains('dsf_skill_6_label')
        skill.innerHTML = 'Fantastic (+6)'

window.fate_core_default_extra_consequences = () ->
  consequences = $('.consequence')
  for consequence in consequences
    label = consequence.children[0]
    title = consequence.children[1]
    if label.innerHTML == aisleten.characters.jeditablePlaceholder or label.innerHTML == ''
      if consequence.classList.contains('mild')
        label.innerHTML = '2'
        title.innerHTML = 'Mild'
      else if consequence.classList.contains('moderate')
        label.innerHTML = '4'
        title.innerHTML = 'Moderate'
      else if consequence.classList.contains('severe')
        label.innerHTML = '6'
        title.innerHTML = 'Severe'
      else
        label.innerHTML = '2'
        title.innerHTML = 'Extra'

window.fate_core_size_points = () ->
  points = $('.points_box').children('.grey').children('.dsf')
  for point in points
    if point.innerHTML == aisleten.characters.jeditablePlaceholder or point.innerHTML == ''
      point.classList.add('placeholder')
    else
      point.classList.remove('placeholder')

window.fate_core_size_avatar = () ->
  avatar = $('.dsf_avatar_image').children().first()
  avatar.load ->
    height = avatar.height()
    width = avatar.width()
    if height > width
      avatar.addClass('tall')
    else
      avatar.addClass('wide')

window.fate_core_set_active_stunts = () ->
  stunts = $('table.stunts').children().children()
  console.log stunts
  for stunt in stunts
    console.log stunt
    activator = stunt.children[2].children[0].children[0].children[0]
    console.log activator
    if activator.value == '1'
      stunt.classList.add('active')
      stunt.classList.remove('inactive')
    else
      stunt.classList.add('inactive')
      stunt.classList.remove('active')

window.fate_core_set_active_consequences = () ->
  consequences = $('.consequence')
  for consequence in consequences
    activator = consequence.children[3].children[0].children[0]
    # We default the main consequences to on for existing chars
    if consequence.classList.contains('extra')
      on_value = '1'
    else
      on_value = '0'
    if activator.value == on_value
      consequence.classList.add('active')
      consequence.classList.remove('inactive')
    else
      consequence.classList.add('inactive')
      consequence.classList.remove('active')

window.fate_core_set_active_stress_tracks = () ->
  tracks = $('.stress_track')
  for track in tracks
    activator = track.children[1].children[0].children[0]
    if activator.value == '0'
      track.classList.add('inactive')
      track.classList.remove('active')
    else
      track.classList.add('active')
      track.classList.remove('inactive')

window.fate_core_set_active_stress_boxes = () ->
  stresses = $('td.stress')
  for entry in stresses
    group = entry.children[0]
    activator = entry.children[1].children[0].children[0]
    if activator.value == '0'
      group.classList.add('inactive')
    else
      group.classList.add('active')

window.fate_core_mark_used_skills = () ->
  listings = $('.skill.inactive')
  for listing in listings
    content = listing.childNodes[1].innerHTML.trim()
    if content.length > 0
      listing.className = 'skill'

window.fate_core_update_active_stunts = (opts) ->
  console.log 'updating stunts'
  name = opts['fieldName']
  console.log name
  value = opts['fieldValue']
  console.log value
  match = name.match(/stunt_(\d\d)_active/)
  console.log match
  return unless match
  stunt = $(".dsf_stunt_#{match[1]}_active")
  console.log stunt
  row = stunt.parent().parent().parent()[0]
  console.log row
  if value == '1'
    row.classList.add('active')
    row.classList.remove('inactive')
  else
    row.classList.add('inactive')
    row.classList.remove('active')

window.fate_core_update_active_consequences = (opts) ->
  name = opts['fieldName']
  value = opts['fieldValue']
  match = name.match(/((\w+)(_\d\d)?)_consequence_activator/)
  return unless match
  consequence = $(".dsf_#{match[1]}_consequence_activator")
  container = consequence.parent().parent()[0]
  if container.classList.contains('extra')
    on_value = '1'
  else
    on_value = '0'
  if value == on_value
    container.classList.add('active')
    container.classList.remove('inactive')
  else
    container.classList.add('inactive')
    container.classList.remove('active')

window.fate_core_update_active_stress_tracks = (opts) ->
  name = opts['fieldName']
  value = opts['fieldValue']
  match = name.match(/extra_(\d\d)_stress_active/)
  return unless match
  track = $(".dsf_extra_#{match[1]}_stress_active")
  if value == '0'
    track.parent().parent().addClass('inactive')
    track.parent().parent().removeClass('active')
  else
    track.parent().parent().addClass('active')
    track.parent().parent().removeClass('inactive')

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

