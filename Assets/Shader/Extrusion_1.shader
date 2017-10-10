// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Test/Unity_wiki/ShadowVolume/Extrusion_1" {  
Properties {  
    _Extrusion ("Extrusion", Range(0,30)) = 5.0  
}  
SubShader {  
    Tags { "Queue" = "Transparent+10" }  
      
    ZWrite Off  
    ColorMask R  
    Offset 1,1  
    pass{  
    CGPROGRAM  
    #pragma vertex vert  
    #pragma fragment frag  
    #include "UnityCG.cginc"  
      
    float _Extrusion;  
    // 【摄像机坐标】中的【光源位置】  
    float4 _LightPosition;    
      
    float4 vert( appdata_base v ) : POSITION {  
 // 通过【模型】到【摄像机】的【逆转矩阵】，将【光源】转到【当前对象】坐标  
        // 注：_LightPosition【行向量】，必须【左乘】矩阵  
        float4 objLightPos = mul( _LightPosition, UNITY_MATRIX_IT_MV );  
        // 【当前顶点】到【光源】的【单位向量】  
        float3 toLight = normalize(objLightPos.xyz - v.vertex.xyz * objLightPos.w);  
        // 求点积，平行方向一样为1，方向相反为-1，垂直为0  
        float backFactor = dot( toLight, v.normal );  
        // 当【点到入射光方向】与【法线】夹角大于90度时extrude为1，需要挤出  
        // 当【点到入射光方向】与【法线】夹角小于90度时extrude为0，无需挤出  
        float extrude = (backFactor < 0.0) ? 1.0 : 0.0;  
        // 根据将【夹角大于90度的顶点】全部挤出。乘以【挤出增量】  
        v.vertex.xyz -= toLight * (extrude * _Extrusion);  
        // 将该顶点输出到屏幕  
        return UnityObjectToClipPos( v.vertex );  
    }  
    float4 frag(float4 pos:POSITION):COLOR  
    {  
        return float4(1,1,1,1);  
    }  
    ENDCG  
    }  
}   
FallBack Off  
}  