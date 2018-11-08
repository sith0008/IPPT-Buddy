package com.example.ipptbuddy;

import org.json.*;
import android.os.Bundle;
import android.os.AsyncTask;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.CancellationException;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import com.ibm.watson.developer_cloud.assistant.v1.Assistant;
import com.ibm.watson.developer_cloud.assistant.v1.model.*;



public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "ipptbuddy/chatbot";
  Assistant myConversationService = new Assistant(
          "2018-07-10",
          "5b0ade52-358d-4fc3-9803-f9dfe48267b7",
          "uEMPa7eVKFNl");

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    myConversationService.setEndPoint("https://gateway.watsonplatform.net/assistant/api");   //Setting workspace url

    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    //new RetrieveFeedTask().execute(urlToRssFeed);

    //Creates new Method channel to communicate with flutter
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodCallHandler(){
              @Override
              public void onMethodCall(MethodCall call, MethodChannel.Result result){
                if(call.method.equals("getChatbotMessage")){
                  String content = call.argument("content");
                  String chatbotMsg = "Sthing wrong...";
                  try {
                    chatbotMsg = new TalkToWatson().execute(content).get();
                  }catch(InterruptedException ie){
                    System.out.println(ie);
                  }catch(ExecutionException ee){
                    System.out.println(ee);
                  }catch(CancellationException ce){
                    System.out.println(ce);
                  }
                  //getChatbotMessage(content);//String chatbotMessage = getChatbotMessage(content);
                  //if (chatbotMessage != null) {
                  result.success(chatbotMsg);//chatbotMessage); //May need to do checks if success
                  //}
                }else{
                  result.notImplemented();
                }
              }
            });
  }

  /**
   * Class that does async calls to watson server using watson API
   * Only uses watson assistant API for chatbot functionality
   */
  private class TalkToWatson extends AsyncTask<String, String, String>{
    @Override
    protected String doInBackground(String... content){
      return getChatbotMessage(content[0]);
    }

    @Override
    protected void onPostExecute(String results){}

    /**
     * Method to send message to watson chatbot and get a reply
     *
     * @param content - message to send to watson chatbot
     * @return a String containing watson chatbot's reply
     */
    private String getChatbotMessage(String content){
      String output = "Sthing wrong...";
      InputData input = new InputData.Builder(content).build();
      MessageOptions options = new MessageOptions.Builder("af54bc8f-e36b-4eda-8443-ae44b11f9270")
              .input(input).build();
      MessageResponse response = myConversationService.message(options).execute();
      JSONObject resp = new JSONObject(response);
      System.out.println(resp);
      try {
        output = resp.getJSONObject("output").getJSONArray("text").get(0).toString();
      } catch(JSONException JSONe){
        System.out.println(JSONe);
      }
      return output;
    }
  }
}//End