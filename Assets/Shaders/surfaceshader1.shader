 Shader "Example/surfaceshader1" { 
 	
    Properties {
      _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader {
      Tags { "RenderType" = "Opaque" }
      CGPROGRAM 
      
      #pragma debug tesatewa,that is 
      #pragma surface surf Lambert
      struct Input {
          float2 uv_MainTex;
      }; 
      
      #pragma debug Use the smapler2D to give a texture.!
      sampler2D _MainTex;
      void surf (Input IN, inout SurfaceOutput o) { 
       		#pragma debug return surf
          o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
      }
      ENDCG
    } 
    Fallback "Diffuse"
  } 
 