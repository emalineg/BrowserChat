import consumer from "./consumer"

consumer.subscriptions.create("MessagesChannel", {
    connected() {
        console.log("Connected to the chat room!");
    },
    disconnected() {
        console.log("Disconnected from the chat room...");
    },
    received(data) {
        console.log("Received data: ", data);
        const messagesContainer = document.getElementById('messages-container');
        const messageInput = document.getElementById('message_content');

        if (messagesContainer) {
            const bubble = document.createElement('div');
            bubble.classList.add('message-bubble');
            bubble.textContent = data.messages[data.messages.length - 1].content; 
            messagesContainer.appendChild(bubble);

            if (messageInput) {
                messageInput.value = ''; 
            }

            const allMessages = messagesContainer.getElementsByClassName('message-bubble');
            if (allMessages.length > 3) {
                messagesContainer.removeChild(allMessages[0]);
            }
        }
    }
});