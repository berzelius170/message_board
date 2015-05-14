



$('#new_thread').hide();

function show_thread() {
    $('#new_thread').show()
}

$('#new_thread_button').click(show_thread);

$('#new_post').hide();

function show_post() {
    $('#new_post').show()
}

$('#new_post_button').click(show_post);

$('#new_comment').hide();

function show_comment() {
    $('#new_comment').show()
}

$('#new_post_comment').click(show_comment());