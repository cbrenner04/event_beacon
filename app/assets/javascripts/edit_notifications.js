function countChar(input_field) {
    var help_element = document.getElementById('sms-character-count-help');
    help_element.innerHTML = input_field.value.length + ' characters';
};

function appendSmsLink() {
    var sms_body_element = document.getElementById('notification_sms_body');
    var current_sms_body_text = sms_body_element.value;
    var submitted_link = document.getElementById('notification_sms_link').value;
    $.get('/short_url/', { link: submitted_link }).done(function(data) {
        sms_body_element.value = current_sms_body_text + ' ' + data;
        countChar(sms_body_element);
        setCurrentSmsLink(submitted_link);
    });
}

function setCurrentSmsLink(submitted_link) {
    var sms_full_link_element = document.getElementById('sms-full-link');
    sms_full_link_element.innerHTML = 'Current SMS link: ' + submitted_link;
}

function renderEmailPreview(input_object) {
    var url = input_object.form.action + '/preview_email/';
    $.get(url, { email_body: input_object.value });
}
