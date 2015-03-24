$ = jQuery

window.fate_core_dataPreLoad = (options) ->
  # Called just before the data is loaded.

window.fate_core_dataPostLoad = (options) ->
  # Called just after the data is loaded.
  fate_core_mark_used_skills()
  fate_core_set_conditions_or_consequences()
  fate_core_set_active_conditions()
  fate_core_set_active_stress_boxes()
  fate_core_set_active_stress_tracks()
  fate_core_set_active_consequences()
  fate_core_set_active_stunts()
  fate_core_set_active_aspects()
  fate_core_size_avatar()
  fate_core_size_points()
  fate_core_default_extra_consequences()
  fate_core_default_skill_names()
  fate_core_default_aspect_names()
  fate_core_hide_last_table_row()
  fate_core_resize_name()

window.fate_core_dataChange = (options) ->
  # Called immediately after a data value is changed.
  fate_core_update_skill(options)
  fate_core_update_condition(options)
  fate_core_activate_conditions_or_consequences(options)
  fate_core_update_active_stress(options)
  fate_core_update_active_stress_tracks(options)
  fate_core_update_active_consequences(options)
  fate_core_update_active_stunts(options)
  fate_core_set_active_aspects()
  fate_core_size_points()
  fate_core_default_extra_consequences()
  fate_core_default_skill_names()
  fate_core_default_aspect_names()

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

window.fate_core_default_aspect_names = () ->
  aspects = $('.aspect_name')
  for aspect in aspects
    aspect = $(aspect)
    if aspect.text() == aisleten.characters.jeditablePlaceholder or aspect.text() == ''
      if aspect.hasClass('dsf_concept_label')
        aspect.text('High Concept')
      else if aspect.hasClass('dsf_trouble_label')
        aspect.text('Trouble')
      else if aspect.hasClass('dsf_your_adventure_label')
        aspect.text('Your Adventure')
      else if aspect.hasClass('dsf_crossing_paths_label')
        aspect.text('Crossing Paths')
      else if aspect.hasClass('dsf_crossing_paths_again_label')
        aspect.text('Crossing Paths Again')
      
window.fate_core_set_active_conditions = () ->
  conditions = $('td.conditions')
  for condition in conditions
    condition = $(condition)
    label = $(condition.children('span'))
    enable_or_disable_conditions(label)

window.fate_core_default_skill_names = () ->
  skills = $('.skill_name')
  for skill in skills
    skill = $(skill)
    if skill.text() == aisleten.characters.jeditablePlaceholder or skill.text() == ''
      if skill.hasClass('dsf_skill_1_label')
        skill.text('Average (+1)')
      else if skill.hasClass('dsf_skill_2_label')
        skill.text('Fair (+2)')
      else if skill.hasClass('dsf_skill_3_label')
        skill.text('Good (+3)')
      else if skill.hasClass('dsf_skill_4_label')
        skill.text('Great (+4)')
      else if skill.hasClass('dsf_skill_5_label')
        skill.text('Superb (+5)')
      else if skill.hasClass('dsf_skill_6_label')
        skill.text('Fantastic (+6)')

window.fate_core_default_extra_consequences = () ->
  consequences = $('.consequence')
  for consequence in consequences
    consequence = $(consequence)
    label = consequence.children('.sheet_label')
    title = consequence.children('.sheet_title')
    if label.text() == aisleten.characters.jeditablePlaceholder or label.text() == '' or title.text() == aisleten.characters.jeditablePlaceholder or title.text() == ''
      if consequence.hasClass('mild')
        label.text('2')
        title.text('Mild')
      else if consequence.hasClass('moderate')
        label.text('4')
        title.text('Moderate')
      else if consequence.hasClass('severe')
        label.text('6')
        title.text('Severe')
      else
        label.text('2')
        title.text('Extra')

window.fate_core_size_points = () ->
  points = $('.points_box').children('.grey').children('.dsf')
  for point in points
    point = $(point)
    if point.text() == aisleten.characters.jeditablePlaceholder or point.text() == ''
      point.addClass('placeholder')
    else
      point.removeClass('placeholder')

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
  for stunt in stunts
    stunt = $(stunt)
    activator = stunt.children().children('.activator').children('span').children('input')
    if activator.val() == '1'
      stunt.addClass('active')
      stunt.removeClass('inactive')
    else
      stunt.addClass('inactive')
      stunt.removeClass('active')

window.fate_core_set_active_aspects = () ->
  aspects = $('.aspect')
  for aspect in aspects
    aspect = $(aspect)
    activator = aspect.children('.activator').children('span').children('input')
    if aspect.hasClass('extra')
      on_value = '1'
    else
      on_value = '0'
    if activator.val() == on_value
      aspect.addClass('active')
      aspect.removeClass('inactive')
    else
      aspect.addClass('inactive')
      aspect.removeClass('active')

window.fate_core_set_active_consequences = () ->
  consequences = $('.consequence')
  for consequence in consequences
    consequence = $(consequence)
    activator = consequence.children('.activator').children('span').children('input')
    # We default the main consequences to on for existing chars
    if consequence.hasClass('extra')
      on_value = '1'
    else
      on_value = '0'
    if activator.val() == on_value
      consequence.addClass('active')
      consequence.removeClass('inactive')
    else
      consequence.addClass('inactive')
      consequence.removeClass('active')

window.fate_core_set_conditions_or_consequences = () ->
  toggle = $('.dsf_conditions_active').children('input')
  consequences = $('.consequences.container')
  conditions = $('.conditions.container')
  if toggle.val() == '0'
    consequences.removeClass('hidden')
    conditions.addClass('hidden')
  else
    conditions.removeClass('hidden')
    consequences.addClass('hidden')

window.fate_core_set_active_stress_tracks = () ->
  tracks = $('.stress_track')
  for track in tracks
    track = $(track)
    activator = track.children('.activator').children('.dsf').children('input')
    if activator.val() == '0'
      track.addClass('inactive')
      track.removeClass('active')
    else
      track.addClass('active')
      track.removeClass('inactive')

window.fate_core_set_active_stress_boxes = () ->
  stresses = $('td.stress')
  stresses.each (index, entry) ->
    entry = $(entry)
    group = entry.children('.group')
    activator = entry.children('.activator').children('.dsf').children('input')
    if activator.val() == '0'
      group.addClass('inactive')
    else
      group.addClass('active')

window.fate_core_mark_used_skills = () ->
  listings = $('li.skill')
  for listing in listings
    listing = $(listing)
    if listing.text().trim().length > 0
      listing.removeClass('inactive')
      listing.addClass('active')
    else
      listing.removeClass('active')
      listing.addClass('inactive')

window.fate_core_update_active_stunts = (opts) ->
  name = opts['fieldName']
  value = opts['fieldValue']
  match = name.match(/stunt_(\d\d)_active/)
  return unless match
  stunt = $(".dsf_stunt_#{match[1]}_active")
  row = stunt.parent().parent().parent()
  if value == '1'
    row.addClass('active')
    row.removeClass('inactive')
  else
    row.addClass('inactive')
    row.removeClass('active')

window.fate_core_update_active_consequences = (opts) ->
  name = opts['fieldName']
  value = opts['fieldValue']
  match = name.match(/((\w+)(_\d\d)?)_consequence_activator/)
  return unless match
  consequence = $(".dsf_#{match[1]}_consequence_activator")
  container = consequence.parent().parent()
  if container.hasClass('extra')
    on_value = '1'
  else
    on_value = '0'
  if value == on_value
    container.addClass('active')
    container.removeClass('inactive')
  else
    container.addClass('inactive')
    container.removeClass('active')

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

window.fate_core_activate_conditions_or_consequences = (opts) ->
  name = opts['fieldName']
  value = opts['fieldValue']
  match = name.match(/conditions_active/)
  return unless match
  fate_core_set_conditions_or_consequences()


window.enable_or_disable_conditions = (label) ->
  groups = label.parent().children('.group')
  if label.text() == aisleten.characters.jeditablePlaceholder or label.text() == ''
    for group in groups
      group = $(group)
      group.addClass('inactive')
      group.removeClass('active')
  else
    for group in groups
      group = $(group)
      group.addClass('active')
      group.removeClass('inactive')

window.fate_core_update_condition = (opts) ->
  name = opts['fieldName']
  value = opts['fieldValue']
  match = name.match(/(\w+)_condition_(\d\d)_label/)
  return unless match
  label = $(".dsf_#{name}").first()
  enable_or_disable_conditions(label)

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

