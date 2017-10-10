Shader "Test/TestBlending" {
	Properties
	{
		_MainTex("Base (RGB)", 2D) = "white" {}
	}
	SubShader
	{
		Tags{ "Queue" = "Transparent" }
		//最终的颜色=源颜色*SrcFactor+目标颜色*DstFactor   目标颜色（就是已经渲染过的颜色）
		Blend One One  
		//Blend One Zero  
		//Blend Zero One
		//Blend SrcColor Zero  
		//Blend SrcAlpha Zero  

		//Blend SrcAlpha DstAlpha
		//Blend SrcAlpha OneMinusSrcAlpha
		//Blend SrcColor OneMinusSrcColor

		Pass
		{
			SetTexture[_MainTex] {}
		}
	}
	FallBack "Diffuse"
}
