## Simple Firebase Chat function

### Step 1

   Download and place Message.dart file in lib 
  
### Step 2

   To Initialize a message Event ,Create an object of Message by passing argument as  sender_id  & message_id
  ```
  
   Message message = Message(messageId: "MESSAGE_ID", senderId: "USER_ID");
  
  ```
  
  ### Start Message Listener

   To Create a message Listerner Event ,Create an object of Message by passing argument as  sender_id  & message_id
  ```
  
   message.startMessageListerner((chatMessage) {
  
      // do you need
      
    });
  
  ```
  In above code chatMessage is a list, which has messages as in the list formate

   #### Sample for  Message Listerner
   
   ```
   message.startMessageListerner((chatMessage) {
      for (MessageData mess in chatMessage) {

        print(mess.message); // to get message content
        
        print(mess.dateTime); // to get message data and time
    
        print(mess.from); // if true , it's send by the user, else it's receive by user
        
      }
    });
  
   ```
   
   ### To sent Message 
      
      ```
       message.sendMessage(" MESSAGE_CONTENT ");
       
      ```
  
  
  
