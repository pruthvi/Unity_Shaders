Shader "Custom/UnlitShader1"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex ("Texture", 2D) = "white" {}
		_Distance("Distance", Range(0.0,2.0)) = 1
        _Amplitude("Amplitude", Float) = 1
        _Speed ("Speed", Float) = 1
        _Amount("Amount", Range(0.0,1.0)) = 1
		_ScrollSpeed ("Scroll Speed", Range(0,10)) = 2

	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			float4 _Color;
			sampler2D _MainTex;
			float4 _MainTex_ST;

			float _Distance;	// How far will the object travel for animation
            float _Amplitude;	// Amount of waves
            float _Speed;		// Speed of animation
            float _Amount;		// Amount of streching vertex

			fixed _ScrollSpeed;


			v2f vert (appdata v)
			{
				v2f o;
				v.vertex.x += sin(_Time.y * _Speed + v.vertex.x * _Amplitude) * _Distance * _Amount;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed2 scrolledUV = i.uv;
				fixed ScrollValue = _ScrollSpeed * _Time;
				scrolledUV += fixed(ScrollValue);

				float4 textureColour = tex2D (_MainTex, scrolledUV);

				//float4 textureColour = tex2D (_MainTex, i.uv);

				return textureColour * _Color;
			}
			ENDCG
		}
	}
}
