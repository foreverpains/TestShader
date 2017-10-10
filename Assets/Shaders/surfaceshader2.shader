  Shader "Example/surfaceshader2" { 
    Properties {
      MyTex ("Texture", 2D) = "red" {}
    }
    SubShader {
      Tags { "RenderType" = "Opaque" }
      CGPROGRAM
      #pragma surface surf Lambert
      struct Input {
          float2 uvMyTex;
      };
      sampler2D MyTex;
      void surf (Input IN, inout SurfaceOutput o) {
          o.Albedo = tex2D (MyTex,IN.uvMyTex).rgb;
          //o.Albedo = 0;
      }
      ENDCG
    } 
    Fallback "Diffuse"
  }