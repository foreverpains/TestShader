// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Test/TestVertex1"
{ //删除每个模型的上半部分
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Amount ("Amount", Range(-2,2)) = 0   
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			Cull Off // 关掉裁剪模式，作用后面再说
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"


			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
				float4 posInObjectCoords : TEXCOORD1;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _Amount;
			
			v2f vert (appdata_full v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord , _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				o.posInObjectCoords = v.vertex;//直接把vertex传递给片段着色器
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				if (i.posInObjectCoords.y > _Amount)
				{
					discard;
				}
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);				
				return col;
			}
			ENDCG
		}
	}
}
