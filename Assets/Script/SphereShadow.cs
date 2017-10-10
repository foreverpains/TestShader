using UnityEngine;
using System.Collections;

public class SphereShadow : MonoBehaviour
{
    public GameObject sphere;
    void Update()
    {
        Vector3 pos = sphere.transform.localPosition;
        GetComponent<Renderer>().sharedMaterial.SetVector("_spPos", new Vector4(pos.x, pos.y, pos.z, 1f));
        GetComponent<Renderer>().sharedMaterial.SetFloat("_spR", sphere.transform.localScale.x / 2);
    }
}