
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
  fate_core_update_skill(options['fieldName'], options['fieldValue'])

window.fate_core_dataPreSave = (options) ->
  # Called just before the data is saved to the server.
  # alert("dataPreSave")

# You can define your own variables...just make sure to namespace them!

window.fate_core_update_skill = (name, value) ->
  console.log name
  console.log value
  skill = $('.dsf_'+name)[0]
  initial_value = skill.innerText
  console.log initial_value
  console.log skill
  unless value
    console.log 'this is blank'
window.fate_core_skill_html = (skill, rank, i) ->
  i = "00" + i.toString()
  '<li><span class="dsf dsf_skill_'+rank+'_'+i.slice(-2)+'">' + skill + '</span></li>'

window.fate_core_render_skills = () ->
  for rank, value of @skills
    # Add an extra blank cell for borders and to add into
    value.push('') if value[value.length-1] or value.length == 0
    console.log rank
    console.log value
    holder = $('.skill.'+rank).children('.skill_holder')[0]
    html = '<ul>'
    for s, i in value
      html = html + fate_core_skill_html(s, rank, i)
    html = html + '</ul>'
    holder.innerHTML = html
  console.log 'skills rendered'

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

