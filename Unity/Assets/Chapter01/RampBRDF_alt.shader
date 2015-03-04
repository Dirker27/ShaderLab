// A faked BRDF using a Ramp Texture
//
Shader "DSV_Shader_Lab/RampBRDF" {

	// Publicly Settable Fields
	Properties {
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
		
		sampler2D _RampTex;
		//
		struct Input {
			float2 uv_MainTex;
		};
		
		//--- Lighting Model ------------------------------=
		//
		inline float4 LightingBasicDiffuse (SurfaceOutput s, fixed3 lightDir, half3 viewDir, fixed atten) {
			
			float difLight = dot(s.Normal, lightDir);
			float rimLight = dot(s.Normal, viewDir);
			
			float hLambert = (difLight * 0.5f) + 0.5f;
			float2 brdfUV = float2(difLight, hLambert);
			float BRDF = tex2D(_RampTex, brdfUV.xy).rgb;
			
			float4 col;
			col.rgb = BRDF;
			//col.rgb = s.Albedo * _LightColor0.rgb * (ramp);
			col.a = s.Alpha;
			return col;
		}
		
		
		//--- Surface Model -------------------------------=
		//
		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = float4(0.75, 0.75, 0.75, 1);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		
		ENDCG
	} 
	FallBack "Diffuse"
}

