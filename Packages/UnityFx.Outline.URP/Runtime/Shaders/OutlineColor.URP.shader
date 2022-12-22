// Copyright (C) 2019-2021 Alexander Bogarsukov. All rights reserved.
// See the LICENSE.md file in the project root for more information.

// Renders everything with while color.
// Modified version of 'Custom/DrawSimple' shader taken from https://willweissman.wordpress.com/tutorials/shaders/unity-shaderlab-object-outlines/.
Shader "Hidden/UnityFx/OutlineColor.URP"
{
	HLSLINCLUDE

		#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
		#include "Packages/com.unity.render-pipelines.universal/Shaders/PostProcessing/Common.hlsl"

		TEXTURE2D(_MainTex);
		SAMPLER(sampler_MainTex);

		//CBUFFER_START(UnityPerMaterial)
		//	// The following line declares the _BaseMap_ST variable, so that you
		//	// can use the _BaseMap variable in the fragment shader. The _ST
		//	// suffix is necessary for the tiling and offset function to work.
		//	float4 _MainTex_ST;
		//CBUFFER_END

		half _Cutoff;

		//struct Attributes
		//{
		//	float2 uv : TEXCOORD0;
		//};

		//struct Varyings
		//{
		//	float2 uv : TEXCOORD0;
		//};

		//Varyings Vert(Attributes IN)
		//{
		//	Varyings OUT;
		//	OUT.uv = TRANSFORM_TEX(IN.uv, _MainTex);
		//	OUT.uv = IN.uv;
		//	return OUT;
		//}

		half4 FragmentSimple(Varyings input) : SV_Target
		{
			return 1;
		}

		half4 FragmentAlphaTest(Varyings input) : SV_Target
		{
			half4 c = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, input.uv);
			clip(c.a - _Cutoff);
			return 1;
		}

	ENDHLSL

	SubShader
	{
		Tags { "RenderPipeline" = "UniversalPipeline" }

		Cull Off
		ZWrite Off
		ZTest LEqual
		Lighting Off

		Pass
		{
			Name "Opaque"

			HLSLPROGRAM

			#pragma multi_compile_instancing
			#pragma vertex Vert
			#pragma fragment FragmentAlphaTest

			ENDHLSL
		}

		Pass
		{
			Name "Transparent"

			HLSLPROGRAM

			#pragma multi_compile_instancing
			#pragma vertex Vert
			#pragma fragment FragmentAlphaTest

			ENDHLSL
		}
	}
}
