// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Test/TestVertex"
{ //删除每个uv 的上半部分
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
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
			
			v2f vert (appdata_full v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord , _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				o.posInObjectCoords = v.texcoord;//直接把texcoord传递给片段着色器
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				//if (i.posInObjectCoords.y > 0.5)
				//{
				//	discard;
				//}

				clip(0.5 - i.posInObjectCoords.y);
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
