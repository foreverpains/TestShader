// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

 Shader "Esfog/DissolveWorldPos"
{
	    Properties
        {
		         	_MainTex("Base (RGB)", 2D) = "white" {}
		         	_NoiseTex("NoiseTex (R)", 2D) = "white"{}
		         	_DissolveSpeed("DissolveSpeed (Second)", Float) = 1
			        _EdgeWidth("EdgeWidth", Range(0, 0.5)) = 0.1
			        _EdgeColor("EdgeColor", Color) = (1, 1, 1, 1)
			        _Amount ("Disslove Amount", Range(0,1)) = 0   
					_CullPos ("裁剪球位置", Range(0, 3)) = 3
					_CullRadius ("裁剪球半径", Range(0.1, 5)) = 1
	    }
	     SubShader
		     {
		         Tags{ "RenderType" = "Opaque" }
		
			         Pass
			         {
			             CGPROGRAM
				             #pragma vertex vert
				             #pragma fragment frag
				             #include "UnityCG.cginc"
				
				            uniform sampler2D _MainTex;
			            	uniform sampler2D _NoiseTex;
			            	uniform float _DissolveSpeed;
			            	uniform float _EdgeWidth;
							uniform float _Amount;
			            	uniform float4 _EdgeColor;
							uniform float _CullPos;
							uniform float _CullRadius;


							inline float GetDis(float3 pos)
							{
								return distance(pos, float3(_CullPos, _CullPos, _CullPos));
							}
							struct v2f
							{
								float2 uv : TEXCOORD0;
								UNITY_FOG_COORDS(1)
								float4 vertex : SV_POSITION;
								//float4 worldSpacePos : TEXCOORD1;
								float4 localPos : TEXCOORD1;
							};

							v2f vert (appdata_full v)
							{
								v2f o;
								o.vertex = UnityObjectToClipPos(v.vertex);
								//o.uv = TRANSFORM_TEX(v.texcoord , _MainTex);
								o.uv = v.texcoord.xy;
								UNITY_TRANSFER_FOG(o,o.vertex);
								//o.worldSpacePos = mul(_Object2World, v.vertex);;//世界坐标
								o.localPos = v.vertex;
								return o;
							}

				             float4 frag(v2f i) :COLOR
				             {
				                 float DissolveFactor = saturate(_Amount / _DissolveSpeed);
				                
								 if(abs(GetDis(i.localPos.xyz)) <= _CullRadius){
									float noiseValue = tex2D(_NoiseTex, i.uv).r;
									if (noiseValue <= DissolveFactor)
									{
										discard;
									}				
									 float4 texColor = tex2D(_MainTex, i.uv);
									 float EdgeFactor = saturate((noiseValue - DissolveFactor) / (_EdgeWidth*DissolveFactor));
									 float4 BlendColor = texColor * _EdgeColor;
				
									 return lerp(texColor, BlendColor, 1 - EdgeFactor);	                    
					             }
				
								fixed4 col = tex2D(_MainTex, i.uv);
								// apply fog
								UNITY_APPLY_FOG(i.fogCoord, col);				
								return col;
				             }
			
				             ENDCG
				         }
		     }
	
		     FallBack Off
		 }