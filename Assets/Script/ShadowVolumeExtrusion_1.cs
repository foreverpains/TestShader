using UnityEngine;
using System.Collections;
[ExecuteInEditMode]
public class ShadowVolumeExtrusion_1 : MonoBehaviour
{

    public Light shadowLight;
    public Material extrusionMat;
    public float extrusionDistance = 20.0f;

    void Update() { }

    void OnPostRender()
    {
        if (!enabled) return;

        Vector4 lightPos;
        if (shadowLight.type == LightType.Directional)
        {
            Vector3 dir = -shadowLight.transform.forward;
            // 将【世界坐标】中的【光方向】变换到【摄像机坐标】中  
            dir = transform.InverseTransformDirection(dir);
            // 【平行光】表示方向，（向量）转为齐次坐标时W是0，表示无限远。  
            lightPos = new Vector4(dir.x, dir.y, -dir.z, 0.0f);
        }
        else
        {
            Vector3 pos = shadowLight.transform.position;
            // 将【世界坐标】中的【光位置】变换到【摄像机坐标】中  
            pos = transform.InverseTransformPoint(pos);
            // 【点光源】表示位置，(点)转为齐次坐标时W是1  
            lightPos = new Vector4(pos.x, pos.y, -pos.z, 1.0f);
        }
        // 【光源】在【摄像机坐标】中的位置  
        extrusionMat.SetVector("_LightPosition", lightPos);
    }
}