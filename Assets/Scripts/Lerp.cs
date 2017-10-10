using UnityEngine;
using System.Collections;

public class Lerp : MonoBehaviour {
    
    public Vector3 newPos;
    // Use this for initialization
    void Start () {
        //newPos = transform.position;
    }
    
    // Update is called once per frame
    void Update () {
		//print ( "Time delta value:" + Time.deltaTime + ", Time value: " + Time.time );
        if(Input.GetKeyDown(KeyCode.Q))
            newPos = new Vector3(-3,8,22);
        if(Input.GetKeyDown(KeyCode.E))
            newPos = new Vector3(3,8,22);
        
        transform.position = Vector3.Lerp(transform.position,newPos,Time.time/10);
    }
}