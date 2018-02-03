function countChar(input_field) {
    var help_element = document.getElementById('sms-character-count-help');
    help_element.innerHTML = input_field.value.length + ' characters';
};

function appendSmsLink() {
    var sms_body_element = document.getElementById('notification_sms_body');
    var submitted_link = document.getElementById('notification_sms_link').value;
    $.ajax({
        url: '/short_url/',
        data: { link: submitted_link },
        success: function(data) {
            sms_body_element.innerHTML = sms_body_element.value + ' ' + data;
            countChar(sms_body_element);
        }
    });
}
