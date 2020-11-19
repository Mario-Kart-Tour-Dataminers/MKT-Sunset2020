//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Blend_AlbScr_MskScr_CulBack_Wave" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("RGB(UV0)", 2D) = "white" { }
[Header(RGB UV Scroll)] _AlbedoScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_AlbedoScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
_AlphaTexture ("A(UV0)", 2D) = "black" { }
[Header(A UV Scroll)] _AlphaTextureScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_AlphaTextureScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
[Header(Vertex Wave)] _WaveFreq ("波打つ頻度", Range(0, 10)) = 1
_WaveSpeed ("波速度", Range(-100, 100)) = 1
_WaveHeight ("波の高さ", Range(0, 100)) = 1
_WaveSlopeMag ("傾きの大きさ", Range(0, 1)) = 1
_WaveCenterPos ("波の発生点", Vector) = (0,0,0,0)
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 12251
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 booster_Env;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	float _effectStart;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[1].xz * _WaveCenterPos.yy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WaveCenterPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WaveCenterPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveFreq;
    u_xlat2 = booster_Env.x + (-_effectStart);
    u_xlat0.x = u_xlat2 * _WaveSpeed + (-u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = _WaveHeight * u_xlat0.x + in_POSITION0.y;
    u_xlat0 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec2 u_xlat3;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat3.xy = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD0.xy;
    u_xlat16_1.xyz = texture(_MainTex, u_xlat0.xw).xyz;
    u_xlat0.xy = fract(u_xlat3.xy);
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD1.xy;
    u_xlat16_0 = texture(_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat2 = vs_COLOR0 * _Color;
    SV_Target0.w = u_xlat16_0 * u_xlat2.w;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 booster_Env;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	float _effectStart;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[1].xz * _WaveCenterPos.yy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WaveCenterPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WaveCenterPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveFreq;
    u_xlat2 = booster_Env.x + (-_effectStart);
    u_xlat0.x = u_xlat2 * _WaveSpeed + (-u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = _WaveHeight * u_xlat0.x + in_POSITION0.y;
    u_xlat0 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec2 u_xlat3;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat3.xy = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD0.xy;
    u_xlat16_1.xyz = texture(_MainTex, u_xlat0.xw).xyz;
    u_xlat0.xy = fract(u_xlat3.xy);
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD1.xy;
    u_xlat16_0 = texture(_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat2 = vs_COLOR0 * _Color;
    SV_Target0.w = u_xlat16_0 * u_xlat2.w;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 booster_Env;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	float _effectStart;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[1].xz * _WaveCenterPos.yy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WaveCenterPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WaveCenterPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveFreq;
    u_xlat2 = booster_Env.x + (-_effectStart);
    u_xlat0.x = u_xlat2 * _WaveSpeed + (-u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = _WaveHeight * u_xlat0.x + in_POSITION0.y;
    u_xlat0 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _AlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec2 u_xlat3;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat3.xy = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD0.xy;
    u_xlat16_1.xyz = texture(_MainTex, u_xlat0.xw).xyz;
    u_xlat0.xy = fract(u_xlat3.xy);
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD1.xy;
    u_xlat16_0 = texture(_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    u_xlat2 = vs_COLOR0 * _Color;
    SV_Target0.w = u_xlat16_0 * u_xlat2.w;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
}
}
}
}