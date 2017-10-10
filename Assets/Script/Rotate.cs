using UnityEngine;
using System.Collections;

public class Rotate : MonoBehaviour
{

	// Use this for initialization
	void Start () {
        Material m = gameObject.GetComponent<MeshRenderer>().material;
        var color = m.color;
        color.a = 0.0f;
        m.color = color;
	}
    public int Speed = 2;
	// Update is called once per frame
	void Update () {
        //transform.Rotate(0, Speed, 0);       
	}
}
