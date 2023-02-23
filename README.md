# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


$(document).ready ->

  var username = '<%= j @username %>'

  
  updateChat = (data) ->
    $('.chat-box').append """
      <div class="col-12">
        <div class="chat bg-secondary d-inline-block text-left text-white mb-2">
          <div class="chat-bubble">
            <small class="chat-username">#{username}</small>
            <p class="m-0 chat-message">#{data.message}</p>
          </div>
        </div>
      </div>
    """
  
  $('.sidebar-form').keyup (event) ->
    if event.keyCode == 13 and !event.shiftKey
      username = event.target.value
      $('.username').append(username)
      $('#username').val(username)
      $('.username').removeClass('d-none')
      $('.sidebar-form').addClass('d-none')
      $('#message').removeAttr("disabled")
      $('#message').focus()
  
  $('#chat-form').on 'ajax:success', (data) ->
    $('#chat-form')[0].reset()
  
  pusher = new Pusher('<%= ENV["PUSHER_KEY"] %>',
    cluster: '<%= ENV["PUSHER_CLUSTER"] %>'
    encrypted: true)
  channel = pusher.subscribe('chat')
  channel.bind 'new', (data) ->
    updateChat data
# Chit-Chat
