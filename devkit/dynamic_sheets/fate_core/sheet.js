(function() {
  var $;

  $ = jQuery;

  window.fate_core_dataPreLoad = function(options) {};

  window.fate_core_dataPostLoad = function(options) {
    fate_core_mark_used_skills();
    fate_core_set_conditions_or_consequences();
    fate_core_set_active_conditions();
    fate_core_set_active_stress_boxes();
    fate_core_set_active_stress_tracks();
    fate_core_set_active_consequences();
    fate_core_set_active_stunts();
    fate_core_set_active_aspects();
    fate_core_size_avatar();
    fate_core_size_points();
    fate_core_default_extra_consequences();
    fate_core_default_skill_names();
    fate_core_default_aspect_names();
    fate_core_hide_last_table_row();
    return fate_core_resize_name();
  };

  window.fate_core_dataChange = function(options) {
    fate_core_update_skill(options);
    fate_core_update_condition(options);
    fate_core_activate_conditions_or_consequences(options);
    fate_core_update_active_stress(options);
    fate_core_update_active_stress_tracks(options);
    fate_core_update_active_consequences(options);
    fate_core_update_active_stunts(options);
    fate_core_set_active_aspects();
    fate_core_size_points();
    fate_core_default_extra_consequences();
    fate_core_default_skill_names();
    return fate_core_default_aspect_names();
  };

  window.fate_core_dataPreSave = function(options) {};

  window.fate_core_hide_last_table_row = function() {
    return $('table.stunts tr:visible:last').addClass('last_row');
  };

  window.fate_core_resize_name = function() {
    return setTimeout((function() {
      var name, results, size;
      name = $('.dsf_name')[0];
      size = 22;
      name.style.fontSize = size + "px";
      results = [];
      while (name.offsetWidth > 235) {
        size--;
        results.push(name.style.fontSize = size + "px");
      }
      return results;
    }), 1000);
  };

  window.fate_core_default_aspect_names = function() {
    var aspect, aspects, i, len, results;
    aspects = $('.aspect_name');
    results = [];
    for (i = 0, len = aspects.length; i < len; i++) {
      aspect = aspects[i];
      aspect = $(aspect);
      if (aspect.text() === aisleten.characters.jeditablePlaceholder || aspect.text() === '') {
        if (aspect.hasClass('dsf_concept_label')) {
          results.push(aspect.text('High Concept'));
        } else if (aspect.hasClass('dsf_trouble_label')) {
          results.push(aspect.text('Trouble'));
        } else if (aspect.hasClass('dsf_your_adventure_label')) {
          results.push(aspect.text('Your Adventure'));
        } else if (aspect.hasClass('dsf_crossing_paths_label')) {
          results.push(aspect.text('Crossing Paths'));
        } else if (aspect.hasClass('dsf_crossing_paths_again_label')) {
          results.push(aspect.text('Crossing Paths Again'));
        } else {
          results.push(void 0);
        }
      } else {
        results.push(void 0);
      }
    }
    return results;
  };

  window.fate_core_set_active_conditions = function() {
    var condition, conditions, group, i, label, len, results;
    conditions = $('td.conditions');
    results = [];
    for (i = 0, len = conditions.length; i < len; i++) {
      condition = conditions[i];
      condition = $(condition);
      group = $(condition.children()[0]);
      label = $(condition.children()[1]);
      if (label.text() === aisleten.characters.jeditablePlaceholder || label.text() === '') {
        group.addClass('inactive');
        results.push(group.removeClass('active'));
      } else {
        group.addClass('active');
        results.push(group.removeClass('inactive'));
      }
    }
    return results;
  };

  window.fate_core_default_skill_names = function() {
    var i, len, results, skill, skills;
    skills = $('.skill_name');
    results = [];
    for (i = 0, len = skills.length; i < len; i++) {
      skill = skills[i];
      skill = $(skill);
      if (skill.text() === aisleten.characters.jeditablePlaceholder || skill.text() === '') {
        if (skill.hasClass('dsf_skill_1_label')) {
          results.push(skill.text('Average (+1)'));
        } else if (skill.hasClass('dsf_skill_2_label')) {
          results.push(skill.text('Fair (+2)'));
        } else if (skill.hasClass('dsf_skill_3_label')) {
          results.push(skill.text('Good (+3)'));
        } else if (skill.hasClass('dsf_skill_4_label')) {
          results.push(skill.text('Great (+4)'));
        } else if (skill.hasClass('dsf_skill_5_label')) {
          results.push(skill.text('Superb (+5)'));
        } else if (skill.hasClass('dsf_skill_6_label')) {
          results.push(skill.text('Fantastic (+6)'));
        } else {
          results.push(void 0);
        }
      } else {
        results.push(void 0);
      }
    }
    return results;
  };

  window.fate_core_default_extra_consequences = function() {
    var consequence, consequences, i, label, len, results, title;
    consequences = $('.consequence');
    results = [];
    for (i = 0, len = consequences.length; i < len; i++) {
      consequence = consequences[i];
      consequence = $(consequence);
      label = consequence.children('.sheet_label');
      title = consequence.children('.sheet_title');
      if (label.text() === aisleten.characters.jeditablePlaceholder || label.text() === '' || title.text() === aisleten.characters.jeditablePlaceholder || title.text() === '') {
        if (consequence.hasClass('mild')) {
          label.text('2');
          results.push(title.text('Mild'));
        } else if (consequence.hasClass('moderate')) {
          label.text('4');
          results.push(title.text('Moderate'));
        } else if (consequence.hasClass('severe')) {
          label.text('6');
          results.push(title.text('Severe'));
        } else {
          label.text('2');
          results.push(title.text('Extra'));
        }
      } else {
        results.push(void 0);
      }
    }
    return results;
  };

  window.fate_core_size_points = function() {
    var i, len, point, points, results;
    points = $('.points_box').children('.grey').children('.dsf');
    results = [];
    for (i = 0, len = points.length; i < len; i++) {
      point = points[i];
      point = $(point);
      if (point.text() === aisleten.characters.jeditablePlaceholder || point.text() === '') {
        results.push(point.addClass('placeholder'));
      } else {
        results.push(point.removeClass('placeholder'));
      }
    }
    return results;
  };

  window.fate_core_size_avatar = function() {
    var avatar;
    avatar = $('.dsf_avatar_image').children().first();
    return avatar.load(function() {
      var height, width;
      height = avatar.height();
      width = avatar.width();
      if (height > width) {
        return avatar.addClass('tall');
      } else {
        return avatar.addClass('wide');
      }
    });
  };

  window.fate_core_set_active_stunts = function() {
    var activator, i, len, results, stunt, stunts;
    stunts = $('table.stunts').children().children();
    results = [];
    for (i = 0, len = stunts.length; i < len; i++) {
      stunt = stunts[i];
      stunt = $(stunt);
      activator = stunt.children().children('.activator').children('span').children('input');
      if (activator.val() === '1') {
        stunt.addClass('active');
        results.push(stunt.removeClass('inactive'));
      } else {
        stunt.addClass('inactive');
        results.push(stunt.removeClass('active'));
      }
    }
    return results;
  };

  window.fate_core_set_active_aspects = function() {
    var activator, aspect, aspects, i, len, on_value, results;
    aspects = $('.aspect');
    results = [];
    for (i = 0, len = aspects.length; i < len; i++) {
      aspect = aspects[i];
      aspect = $(aspect);
      activator = aspect.children('.activator').children('span').children('input');
      if (aspect.hasClass('extra')) {
        on_value = '1';
      } else {
        on_value = '0';
      }
      if (activator.val() === on_value) {
        aspect.addClass('active');
        results.push(aspect.removeClass('inactive'));
      } else {
        aspect.addClass('inactive');
        results.push(aspect.removeClass('active'));
      }
    }
    return results;
  };

  window.fate_core_set_active_consequences = function() {
    var activator, consequence, consequences, i, len, on_value, results;
    consequences = $('.consequence');
    results = [];
    for (i = 0, len = consequences.length; i < len; i++) {
      consequence = consequences[i];
      consequence = $(consequence);
      activator = consequence.children('.activator').children('span').children('input');
      if (consequence.hasClass('extra')) {
        on_value = '1';
      } else {
        on_value = '0';
      }
      if (activator.val() === on_value) {
        consequence.addClass('active');
        results.push(consequence.removeClass('inactive'));
      } else {
        consequence.addClass('inactive');
        results.push(consequence.removeClass('active'));
      }
    }
    return results;
  };

  window.fate_core_set_conditions_or_consequences = function() {
    var conditions, consequences, toggle;
    toggle = $('.dsf_conditions_active').children('input');
    consequences = $('.consequences.container');
    conditions = $('.conditions.container');
    if (toggle.val() === '0') {
      consequences.removeClass('hidden');
      return conditions.addClass('hidden');
    } else {
      conditions.removeClass('hidden');
      return consequences.addClass('hidden');
    }
  };

  window.fate_core_set_active_stress_tracks = function() {
    var activator, i, len, results, track, tracks;
    tracks = $('.stress_track');
    results = [];
    for (i = 0, len = tracks.length; i < len; i++) {
      track = tracks[i];
      track = $(track);
      activator = track.children('.activator').children('.dsf').children('input');
      if (activator.val() === '0') {
        track.addClass('inactive');
        results.push(track.removeClass('active'));
      } else {
        track.addClass('active');
        results.push(track.removeClass('inactive'));
      }
    }
    return results;
  };

  window.fate_core_set_active_stress_boxes = function() {
    var stresses;
    stresses = $('td.stress');
    return stresses.each(function(index, entry) {
      var activator, group;
      entry = $(entry);
      group = entry.children('.group');
      activator = entry.children('.activator').children('.dsf').children('input');
      if (activator.val() === '0') {
        return group.addClass('inactive');
      } else {
        return group.addClass('active');
      }
    });
  };

  window.fate_core_mark_used_skills = function() {
    var i, len, listing, listings, results;
    listings = $('li.skill');
    results = [];
    for (i = 0, len = listings.length; i < len; i++) {
      listing = listings[i];
      listing = $(listing);
      if (listing.text().trim().length > 0) {
        listing.removeClass('inactive');
        results.push(listing.addClass('active'));
      } else {
        listing.removeClass('active');
        results.push(listing.addClass('inactive'));
      }
    }
    return results;
  };

  window.fate_core_update_active_stunts = function(opts) {
    var match, name, row, stunt, value;
    name = opts['fieldName'];
    value = opts['fieldValue'];
    match = name.match(/stunt_(\d\d)_active/);
    if (!match) {
      return;
    }
    stunt = $(".dsf_stunt_" + match[1] + "_active");
    row = stunt.parent().parent().parent();
    if (value === '1') {
      row.addClass('active');
      return row.removeClass('inactive');
    } else {
      row.addClass('inactive');
      return row.removeClass('active');
    }
  };

  window.fate_core_update_active_consequences = function(opts) {
    var consequence, container, match, name, on_value, value;
    name = opts['fieldName'];
    value = opts['fieldValue'];
    match = name.match(/((\w+)(_\d\d)?)_consequence_activator/);
    if (!match) {
      return;
    }
    consequence = $(".dsf_" + match[1] + "_consequence_activator");
    container = consequence.parent().parent();
    if (container.hasClass('extra')) {
      on_value = '1';
    } else {
      on_value = '0';
    }
    if (value === on_value) {
      container.addClass('active');
      return container.removeClass('inactive');
    } else {
      container.addClass('inactive');
      return container.removeClass('active');
    }
  };

  window.fate_core_update_active_stress_tracks = function(opts) {
    var match, name, track, value;
    name = opts['fieldName'];
    value = opts['fieldValue'];
    match = name.match(/extra_(\d\d)_stress_active/);
    if (!match) {
      return;
    }
    track = $(".dsf_extra_" + match[1] + "_stress_active");
    if (value === '0') {
      track.parent().parent().addClass('inactive');
      return track.parent().parent().removeClass('active');
    } else {
      track.parent().parent().addClass('active');
      return track.parent().parent().removeClass('inactive');
    }
  };

  window.fate_core_update_active_stress = function(opts) {
    var match, name, stress, value;
    name = opts['fieldName'];
    value = opts['fieldValue'];
    match = name.match(/(\w+)_stress_(\d\d)_active/);
    if (!match) {
      return;
    }
    stress = $(".dsf_" + match[1] + "_stress_" + match[2]);
    if (value === "1") {
      stress.parent().addClass('active');
      return stress.parent().removeClass('inactive');
    } else {
      stress.parent().addClass('inactive');
      return stress.parent().removeClass('active');
    }
  };

  window.fate_core_activate_conditions_or_consequences = function(opts) {
    var match, name, value;
    name = opts['fieldName'];
    value = opts['fieldValue'];
    match = name.match(/conditions_active/);
    if (!match) {
      return;
    }
    return fate_core_set_conditions_or_consequences();
  };

  window.fate_core_update_condition = function(opts) {
    var group, label, match, name, value;
    name = opts['fieldName'];
    value = opts['fieldValue'];
    match = name.match(/(\w+)_condition_(\d\d)_label/);
    if (!match) {
      return;
    }
    label = $(".dsf_" + name).first();
    group = label.parent().children().first();
    if (label.text() === aisleten.characters.jeditablePlaceholder || label.text() === '') {
      group.addClass('inactive');
      return group.removeClass('active');
    } else {
      group.addClass('active');
      return group.removeClass('inactive');
    }
  };

  window.fate_core_update_skill = function(opts) {
    var match, name, skill, value;
    name = opts['fieldName'];
    value = opts['fieldValue'];
    match = name.match(/skill_(\w+)_(\d\d)/);
    if (!match) {
      return;
    }
    skill = $(".dsf_" + name).first();
    if (skill.text() === aisleten.characters.jeditablePlaceholder || skill.text() === '') {
      return skill.parent().addClass('inactive');
    } else {
      return skill.parent().removeClass('inactive');
    }
  };

}).call(this);
