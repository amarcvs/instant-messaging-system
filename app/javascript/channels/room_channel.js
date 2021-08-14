import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
  const room_element = document.getElementById('room-id');
  const room_id = room_element.getAttribute('data-room-id');

  console.log(consumer.subscriptions);

  consumer.subscriptions.subscriptions.forEach((subscription) => {
    consumer.subscriptions.remove(subscription)
  });

  consumer.subscriptions.create({ channel: "RoomChannel", room_id: room_id }, {
    connected() {
      // Called when the subscription is ready for use on the server
      console.log("Connected to room " + room_id)
    },
  
    disconnected() {
      // Called when the subscription has been terminated by the server
    },
  
    received(data) {
      // Called when there's incoming data on the websocket for this channel
      
      console.log(data);
  
      const messagewriter_element = document.getElementById('messagewriter-id');
      const messagewriter_id = Number(messagewriter_element.getAttribute('data-messagewriter-id'));
  
      let html;
  
      if(messagewriter_id === data.message.messagewriter_id) {
        html = data.mine;
      } else {
        html = data.theirs;
      }
  
      const messageContainer = document.getElementById('messages');
      messageContainer.innerHTML = messageContainer.innerHTML + html;
    }
  });
})
