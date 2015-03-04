// A Basic Diffuse Shader
// 
// Applies a publicly settable color balance to a surface
// 
Shader "DSV_Shader_Lab/BasicDiffuse" {
	
	// Publicly Settable Fields
	Properties {
		// Emissive Color == Color of light reflected off the object. (Lit surface)
		_EmissiveColor ("Emissive Color", Color) = (1, 1, 1, 1)
		// Ambient Color == Color of unlit surface
		_AmbientColor ("Ambient Color", Color) = (0, 0, 0, 0)
		// How Emissive the surface is
		_InverseLux ("Lux", Range(1, 99)) = 25
		
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
		float _InverseLux;
		
		struct Input
		{
			float2 uv_MainTex;
		};
		
		// Apply color mix to surface
		void surf (Input IN, inout SurfaceOutput o)
		{
			float4 c;
			c = pow((_EmissiveColor + _AmbientColor), 100 - _InverseLux);
			
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		
		ENDCG
	} 
	FallBack "Diffuse"
}
