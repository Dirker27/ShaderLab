// A Ramp Shader with Half Lambert Lighting
//
Shader "DSV_Shader_Lab/HalfLambertRamp" {

	// Publicly Settable Fields
	Properties {
		// Emissive Color == Color of light reflected off the object. (Lit surface)
		_EmissiveColor ("Emissive Color", Color) = (1, 1, 1, 1)
		// Ambient Color == Color of unlit surface
		_AmbientColor ("Ambient Color", Color) = (0, 0, 0, 0)
		// Ramp Texture
		_RampTex ("Ramp Texture", 2D) = "white" {}
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
		sampler2D _RampTex;
		//
		struct Input {
			float2 uv_MainTex;
		};
		
		//--- Lighting Model ------------------------------=
		//
		inline float4 LightingBasicDiffuse (SurfaceOutput s, fixed3 lightDir, fixed atten) {
			float difLight = dot(s.Normal, lightDir);
			float hLambert = difLight * 0.5f + 0.5f;
			float ramp = tex2D(_RampTex, float2(hLambert)).rgb;
			
			float4 col;
			col.rgb = s.Albedo * _LightColor0.rgb * (ramp);
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

