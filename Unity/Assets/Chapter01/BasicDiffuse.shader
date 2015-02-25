Shader "Custom/BasicDiffuse" {
	
	// Publicly Settable Fields
	Properties {
		// Emissive Color == ???
		_EmissiveColor ("Emissive Color", Color) = (1, 1, 1, 1)
		// Ambient Color == ???
		_AmbientColor ("Ambient Color", Color) = (0, 0, 0, 0)
		// Color Saturation Factor
		_Factor ("Factor", Range(0.001, 10)) = 0.5
		
		// Default Base Texture (Unused)
		//_MainTex ("Base (RGB)", 2D) = "white" {}
		
		// --- PROPERTY TYPES -----------------------------=
		//
		// Range(min, max) == Float - bounds inclusive
		// Color == Unity Color Obj ( R[f], B[f], G[f], A[f] )
		// 2D == Unity Texture Obj
		// Rect == "non-power-of-2" texture - 2D GUI Element
		// Cube == Cube Map
		// Vector == (f, f, f, f)
	}
	
	// Shader Program
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert
		
		// Bind to Public Properties by name
		float4 _EmissiveColor;
		float4 _AmbientColor;
		float _Factor;
		
		struct Input
		{
			float2 uv_MainTex;
		};
		
		// Apply color mix to surface
		void surf (Input IN, inout SurfaceOutput o)
		{
			float4 c;
			c = pow((_EmissiveColor + _AmbientColor), _Factor);
			
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		
		ENDCG
		
		// Default Texture Mapper (Unused) ----------------=
		//
		//CGPROGRAM
		//#pragma surface surf Lambert
		//sampler2D _MainTex;
		//struct Input {
		//	float2 uv_MainTex;
		//};
		//void surf (Input IN, inout SurfaceOutput o) {
		//	half4 c = tex2D (_MainTex, IN.uv_MainTex);
		//	o.Albedo = c.rgb;
		//	o.Alpha = c.a;
		//}
		//ENDCG
	} 
	FallBack "Diffuse"
}
