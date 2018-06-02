$(function() {
  var schoolField = $('#school_id');
  var courseField = $('#course_id');
  var serieField = $('#serie_id');
  var classrooms = $('#classrooms');

  schoolField.change(function() { updateClassrooms() });
  courseField.change(function() { updateClassrooms() });
  serieField.change(function() { updateClassrooms() });

  var updateClassrooms = function() {
    if (schoolField.val() && courseField.val() && serieField.val()) {
      classrooms.append(
        // $('<option></option>').val(99).html('teste')
      );
    } else {
      classrooms.find('option').remove().end();
    }
  }
});