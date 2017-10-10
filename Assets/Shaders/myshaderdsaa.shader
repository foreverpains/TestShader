// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/myshader1" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
	
		Pass{
			Tags { "RenderType"="Opaque" }
			LOD 200
			
			CGPROGRAM
			
			#pragma debug gogogogo
			#pragma vertex vertM
			#pragma fragment fragM
			
			float4 vertM(float4 vertPos : POSITION) : SV_POSITION
			{
				return UnityObjectToClipPos(float4(1.0, 0.01, 1.0, 1.0) * vertPos);
			}
			
			float4 fragM(void) : COLOR
			{
				return float4(0.9 , 1.0, 0.0, 1.0);
			}
			ENDCG
		}
	}
}
