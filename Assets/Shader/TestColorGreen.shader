// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Test/TestColorGreen"
{ 
	Properties
	{
		_MainTexR ("Texture", 2D) = "white" {}
		_MainTexG ("Texture", 2D) = "white" {}
		_MainTexB ("Texture", 2D) = "white" {}
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

			sampler2D _MainTexR;
			sampler2D _MainTexG;
			sampler2D _MainTexB;
			float4 _MainTexR_ST;
			
			v2f vert (appdata_full v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord , _MainTexR);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				half r = tex2D(_MainTexR, i.uv).r;
				half g = tex2D(_MainTexG, i.uv).g;
				half b = tex2D(_MainTexB, i.uv).b;
				//fixed4 col = dot(col1.rgb, fixed3(0.22, 0.707, 0.071));   
				//fixed4 col = fixed4(col1.g,col1.g,col1.g,col1.a);
				//fixed4 col = fixed4(0,col1.g,0,col1.a);
				fixed4 col = fixed4(r, g, b, 1);
				//fixed4 col = fixed4(0.1,0.5,0.5,0.5);
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);				
				return col;
			}
			ENDCG
		}
	}
}
