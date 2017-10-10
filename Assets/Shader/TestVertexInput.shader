// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Test/VertexInput" 
{ 
   SubShader 
   { 
      Pass 
      { 
         CGPROGRAM 
 
         #pragma vertex vert  
         #pragma fragment frag 
 
         struct vertexInput 
         {
            float4 vertex : POSITION;
            float4 tangent : TANGENT;  
            float3 normal : NORMAL;
            float4 texcoord : TEXCOORD0;  
            float4 texcoord1 : TEXCOORD1; 
            fixed4 color : COLOR; 
         };
         struct vertexOutput 
         {
            float4 pos : SV_POSITION;
            float4 col : TEXCOORD0;
         };
 
         vertexOutput vert(vertexInput input) 
         {
            vertexOutput output;
 
            output.pos =  UnityObjectToClipPos(input.vertex);
            output.col = input.texcoord; // set the output color
 
            // other possibilities to play with:
 
            // output.col = input.vertex;
            // output.col = input.tangent;
            // output.col = float4(input.normal, 1.0);
            // output.col = input.texcoord;
            // output.col = input.texcoord1;
            // output.col = input.color;
			output.col = float4((input.normal + float3(1.0, 1.0, 1.0)) / 2.0, 1.0);
			output.col = input.texcoord - float4(1.5, 2.3, 1.1, 0.0);
			output.col = input.texcoord - float4(0.5, 0.3, 0.1, 0.0);
			output.col = input.texcoord.rrrr;
			//output.col = input.texcoord / tan(0.0);
			//output.col = dot(input.normal, input.tangent.xyz) * input.texcoord;
			//output.col = dot(cross(input.normal, input.tangent.xyz), input.normal) * input.texcoord;
			//output.col = float4(cross(input.normal, input.normal), 1.0);
			//output.col = float4(cross(input.normal,  input.vertex.xyz), 1.0);
			//output.col = radians(input.texcoord);

            return output;
         }
 
         float4 frag(vertexOutput input) : COLOR 
         {
            return input.col; 
         }
         ENDCG  
      }
   }
}