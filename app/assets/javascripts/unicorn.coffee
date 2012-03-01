$(document).ready ->
	$('#left_nav').scrollspy()
	$('#event_venue_id').chosen()
	$('#event_starts_at,#event_ends_at').datepicker({duration:'',showTime: true,constrainInput: false,stepMinutes: 1,stepHours: 1,altTimeField:'',time24h: false});