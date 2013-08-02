
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
  fate_core_load_skills()

window.fate_core_dataChange = (options) ->
  # Called immediately after a data value is changed.
  # alert("dataChange. " + options['fieldName'] + " = " + options['fieldValue'])
  fate_core_update_skill(options)

window.fate_core_dataPreSave = (options) ->
  # Called just before the data is saved to the server.
  # alert("dataPreSave")

# You can define your own variables...just make sure to namespace them!

# FIXME: Any fields we add aren't linked to the callbacks so
# adding a new field and then editing it won't add a new field.
# Might be able to get around this by inserting the new element before our current
# one, setting it's value to the newly edited value and then setting the old one to 
# an empty string.  That way it should still be in the callback chain
# or whatever the fuck is going on there.
window.fate_core_create_new_skill = (rank, i, content = '') ->
  i = "00" + i.toString()
  li = document.createElement('li')
  span = document.createElement('span')
  span.textContent = content
  span.classList.add("skill_#{rank}")
  span.classList.add('dsf')
  span.classList.add("dsf_skill_#{rank}_#{i.slice(-2)}")
  li.appendChild(span)
  li

window.fate_core_update_skill = (opts) ->
  name = opts['fieldName']
  value = opts['fieldValue']
  match = name.match(/skill_(\w+)_(\d\d)/)
  return unless  match
  rank = match[1]
  skills = $(".skill_#{rank}")
  empty_count = 0
  for skill in skills
    if empty_count > 0
      skill.parentNode.remove()
    else
      empty_count++ if skill.innerText == aisleten.characters.jeditablePlaceholder or skill.innerText == ''
  if empty_count == 0
    i = skills.length.toString()
    new_li = fate_core_create_new_skill(rank, i)

    skills[0].parentNode.parentNode.appendChild(new_li)

  aisleten.characters.bindAllFields(opts['slug'], opts['containerId'])

window.fate_core_render_skills = () ->
  for rank, value of @skills
    # Add an extra blank cell for borders and to add into
    value.push('') if value[value.length-1] or value.length == 0
    holder = $('.skill.'+rank).children('.skill_holder')[0]
    ul = document.createElement('ul')
    for s, i in value
      li = fate_core_create_new_skill(rank, i, s)
      ul.appendChild(li)
      holder.appendChild(ul)

window.fate_core_load_skills = () ->
  @skills = {'average':[], 'fair':[], 'good':[],'great':[], 'superb':[]}
  for key, value of dynamic_sheet_attrs
    match = key.match(/skill_(\w+)_(\d\d)/)
    if match
      if @skills[match[1]]
        @skills[match[1]].push(value)
      else
        @skills[match[1]] = [value]
  fate_core_render_skills()

