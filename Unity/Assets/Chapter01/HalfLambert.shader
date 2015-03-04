// A Half Lambert Shader
// 
// Provides the whole surface a base lighting value
//
// Used for soft lighting effects and low-light environments.
//
Shader "DSV_Shader_Lab/HalfLambert" {

	// Publicly Settable Fields
	Properties {
		// Emissive Color == Color of light reflected off the object. (Lit surface)
		_EmissiveColor ("Emissive Color", Color) = (1, 1, 1, 1)
		// Ambient Color == Color of unlit surface
		_AmbientColor ("Ambient Color", Color) = (0, 0, 0, 0)
	}
	
	// Shader Program
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		
		#pragma surface surf BasicDiffuse
		#pragma target 3.0
		
		float4 _EmissiveColor;
		float4 _AmbientColor;
		//
		struct Input {
			float2 uv_MainTex;
		};
		
		//--- Lighting Model ------------------------------=
		//
		inline float4 LightingBasicDiffuse (SurfaceOutput s, fixed3 lightDir, fixed atten) {
			float difLight = max(0, dot(s.Normal, lightDir));
			float hLambert = difLight * 0.5f + 0.5f;
			
			float4 col;
			col.rgb = s.Albedo * _LightColor0.rgb * (hLambert * atten * 2);
			col.a = s.Alpha;
			return col;
		}
		
		
		//--- Surface Model -------------------------------=
		//
		void surf (Input IN, inout SurfaceOutput o) {
			float4 c;
			c = (_EmissiveColor + _AmbientColor);
			
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		
		ENDCG
	} 
	FallBack "Diffuse"
}

