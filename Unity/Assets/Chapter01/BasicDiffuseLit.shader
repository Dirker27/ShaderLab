// A Diffuse Shader with a Custom Lighting Model
//
//
Shader "DSV_Shader_Lab/BasicDiffuseLit" {
	
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
		// Use surface model 'surf', lighting model 'BasicDiffuse'
		#pragma surface surf BasicDiffuse
		
		float4 _EmissiveColor;
		float4 _AmbientColor;
		
		struct Input {
			float2 uv_MainTex;
		};
		
		//--- Lighting Model -------------------------------=
		//
		inline float4 LightingBasicDiffuse (SurfaceOutput s, fixed3 lightDir, fixed atten) {
			float difLight = max(0, dot(s.Normal, lightDir));
			float4 col;
			col.rgb = s.Albedo * _LightColor0.rgb * (difLight * atten * 2);
			col.a = s.Alpha;
			return col;
		}
		// Alternate Lighting Model Signatures
		//
		// half4 Lighting<Name> (SurfaceOutput s, half3 lightDir, half atten) {}
		// half4 Lighting<Name> (SurfaceOutput s, half3 lightDir, half3 viewDir, half atten) {}
		// half4 Lighting<Name>_PrePass (SurfaceOutput s, half 4 light) {}
		
		
		//--- Surface Model --------------------------------=
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
