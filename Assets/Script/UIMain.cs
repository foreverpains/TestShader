using UnityEngine;
using System.Collections;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using UnityEngine.Events;
public class UIMain : MonoBehaviour {
	Button	button;
	Image image;
	void Start () 
	{
		button = transform.Find("Button").GetComponent<Button>();
		image = transform.Find("Image").GetComponent<Image>();
		EventTriggerListener.Get(button.gameObject).onClick =OnButtonClick;
        EventTriggerListener.Get(image.gameObject).onClick = OnButtonClickImage;
	}
 
	private void OnButtonClick(GameObject go){
		//在这里监听按钮的点击事件
		if(go == button.gameObject){
            Debug.Log("OnButtonClick");
		}
	}


    private void OnButtonClickImage(GameObject go)
    {
        //在这里监听按钮的点击事件
        if (go == image.gameObject)
        {
            Debug.Log("OnButtonClickImage");
        }
    }
}