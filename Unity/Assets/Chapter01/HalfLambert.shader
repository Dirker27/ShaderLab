Shader "Custom/HalfLambert" {
	// Publicly Settable Fields
	Properties {
		// Emissive Color == ???
		_EmissiveColor ("Emissive Color", Color) = (1, 1, 1, 1)
		// Ambient Color == ???
		_AmbientColor ("Ambient Color", Color) = (0, 0, 0, 0)
		// Color Saturation Factor
		_Factor ("Factor", Range(0.0001, 1)) = 0.5
	}
	
	// Shader Program
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		
		//- Lighting Model ------------------------------------------=
		//
		#pragma surface surf BasicDiffuse
		#pragma target 3.0
		inline float4 LightingBasicDiffuse (SurfaceOutput s, fixed3 lightDir, fixed atten) {
			float difLight = max(0, dot(s.Normal, lightDir));
			float hLambert = difLight * 0.5f + 0.5f;
			
			float4 col;
			col.rgb = s.Albedo * _LightColor0.rgb * (hLambert * atten * 2);
			col.a = s.Alpha;
			return col;
		}
		
		
		//- Apply color mix to surface -------------------------------=
		//
		float4 _EmissiveColor;
		float4 _AmbientColor;
		float _Factor;
		//
		struct Input {
			float2 uv_MainTex;
		};
		//
		void surf (Input IN, inout SurfaceOutput o) {
			float4 c;
			c = pow((_EmissiveColor + _AmbientColor), _Factor);
			
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		
		ENDCG
	} 
	FallBack "Diffuse"
}

