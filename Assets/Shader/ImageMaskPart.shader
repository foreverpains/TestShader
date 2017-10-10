Shader "Test/ImageMaskPart" {
	Properties{
	_Color("Main Color", Color) = (1, 1, 1, 1)
	_MainTex("Base (RGB) Trans (A)", 2D) = "white" {}
	_BgTex("Base (RGB) Trans (A)", 2D) = "white" {}
	_SizeX("列数", Float) = 4
	_SizeY("行数", Float) = 4
	_Speed("播放速度", Float) = 200
	_Amount ("Amount", Range(0,360)) = 30   
}

	SubShader{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Lambert alpha

		sampler2D _MainTex;
		sampler2D _BgTex;
		fixed4 _Color;
		float _Amount;

		uniform fixed _SizeX;
		uniform fixed _SizeY;
		uniform fixed _Speed;

		struct Input {
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			float2 start = float2(0.5,1);
			float2 pos = float2(0.5,0.5);
			float2 testUV = IN.uv_MainTex;
			float2 dir =  normalize(testUV - pos);
			float2 dir1 = normalize( start - pos);
			float du = degrees(acos(dot(dir,dir1)));
			if(IN.uv_MainTex.x < 0.5){
				du = 360 - du;
			}
			fixed4 c = tex2D(_MainTex, testUV) ;
			fixed4 cBg = tex2D(_BgTex, IN.uv_MainTex);

			if(du < _Amount){
				o.Albedo = cBg.rgb * _Color;
			}else{				
				o.Albedo = c.rgb * cBg.rgb * _Color * 2;
			}
			//o.Albedo = c;

			o.Alpha = c.a;
			//o.Albedo = float3( floor(_Time .x * _Speed) , 1.0, 1.0);
		}
		ENDCG
	}

	Fallback "Transparent/VertexLit"
	//Fallback "Diffuse"
}