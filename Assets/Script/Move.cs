using UnityEngine;
using System.Collections;

public class Move : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
    public int Speed = 2;
    int dir = 1;
	// Update is called once per frame
	void Update () {
        transform.Translate(Speed*dir * Time.deltaTime, 0, 0);

        if(transform.position.x>5){
             dir = -1;
        }
        if (transform.position.x <-5)
        {
            dir = 1;
        }
	}
}
