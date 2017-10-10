// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Test/SphereShadow_1" {
 Properties {
  _spPos("Sphere pos", vector) = (0,0,0,1)
  _spR("radius", float) = 1
  _Intensity("Intensity", range(0,1)) = 0.5
 }
 SubShader {
  Pass{
   Tags{"LightMode"="ForwardBase"}
   CGPROGRAM
   #pragma vertex vert
   #pragma fragment frag
   #include "UnityCG.cginc"
   float4 _spPos;   // 球体位置
   float _spR;    // 球体半径
   float _Intensity;  // 阴影浓度
   float4 _LightColor0; // 颜色
   struct v2f{
    float4 pos:SV_POSITION;
    float3 litDir:TEXCOORD0;// 世界坐标中灯光方向矢量
    float3 spDir:TEXCOORD1; // 在世界坐标中投影球体方向矢量
    float4 vc:TEXCOORD2; // 逐顶点计算的光照
   };
   v2f vert(appdata_base v)
   {
    v2f o;
    o.pos = UnityObjectToClipPos(v.vertex);// 获取顶点视图位置
    o.litDir = WorldSpaceLightDir(v.vertex);// 获取世界坐标中灯光对顶点的方向矢量
    o.spDir = (_spPos - mul(unity_ObjectToWorld, v.vertex)).xyz;//世界坐标中该顶点到投影球体的矢量
    
    // 顶点的光照计算。该顶点在对象坐标中的光照方向矢量
    float3 ldir = ObjSpaceLightDir(v.vertex);
    ldir = normalize(ldir);
    o.vc = _LightColor0 * max(0, dot(ldir, v.normal));//根据顶点的入射光线和法线角度求该顶点光照
    return o;
   }
   float4 frag(v2f i):COLOR
   {
    float3 litDir = normalize(i.litDir);//获取点的入射线单位向量
    float3 spDir = i.spDir; // 获取该点到投影球体的矢量
    float spDistance = length(spDir); //该点到球体的距离
    spDir = normalize(spDir); //该点到投影球体的单位向量
    float cosV = dot(spDir, litDir);// 该点到球体 与 该点到入射线的夹角
    float sinV = sin(acos(max(0, cosV)));// 拿到余弦值大于0的角度，求正弦
    float D=sinV * spDistance;  // 解三角形,求对边
    float shadow = step(_spR, D); // 如果对边小于半径返回0，该点为阴影点
    float c = lerp(1 - _Intensity, 1, shadow);// shadow由0到1
    return i.vc * c; // 为0的时候是阴影点
   }
   ENDCG
  }
 }
}