//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/Effect/Fx_Add_AlbScr_MskScr_Msk2_Zoff" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("RGB(UV0)", 2D) = "white" { }
[Header(RGB UV Scroll)] _AlbedoScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_AlbedoScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
_AlphaTexture ("A(UV0)", 2D) = "black" { }
[Header(A UV Scroll)] _AlphaTextureScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_AlphaTextureScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
[Header(Alpha 2)] _Alpha2Texture ("A2(UV0)", 2D) = "black" { }
[Header(Z Offset)] _zOffset ("Z Offset", Float) = 0
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 50641
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	vec4 _Alpha2Texture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    vs_TEXCOORD5.xy = in_TEXCOORD0.xy * _Alpha2Texture_ST.xy + _Alpha2Texture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
uniform lowp sampler2D _Alpha2Texture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat3.xy = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD0.xy;
    u_xlat10_1.xyz = texture2D(_MainTex, u_xlat0.xw).xyz;
    u_xlat0.xy = fract(u_xlat3.xy);
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat2 = vs_COLOR0 * _Color;
    u_xlat0.x = u_xlat16_0 * u_xlat2.w;
    SV_Target0.xyz = u_xlat10_1.xyz * u_xlat2.xyz;
    u_xlat10_3 = texture2D(_Alpha2Texture, vs_TEXCOORD5.xy).x;
    u_xlat16_3 = (-u_xlat10_3) + 1.0;
    SV_Target0.w = u_xlat16_3 * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	vec4 _Alpha2Texture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    vs_TEXCOORD5.xy = in_TEXCOORD0.xy * _Alpha2Texture_ST.xy + _Alpha2Texture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
uniform lowp sampler2D _Alpha2Texture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat3.xy = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD0.xy;
    u_xlat10_1.xyz = texture2D(_MainTex, u_xlat0.xw).xyz;
    u_xlat0.xy = fract(u_xlat3.xy);
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat2 = vs_COLOR0 * _Color;
    u_xlat0.x = u_xlat16_0 * u_xlat2.w;
    SV_Target0.xyz = u_xlat10_1.xyz * u_xlat2.xyz;
    u_xlat10_3 = texture2D(_Alpha2Texture, vs_TEXCOORD5.xy).x;
    u_xlat16_3 = (-u_xlat10_3) + 1.0;
    SV_Target0.w = u_xlat16_3 * u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _AlphaTexture_ST;
uniform 	vec4 _Alpha2Texture_ST;
uniform 	float _zOffset;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_zOffset, _zOffset, _zOffset)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _AlphaTexture_ST.xy + _AlphaTexture_ST.zw;
    vs_TEXCOORD5.xy = in_TEXCOORD0.xy * _Alpha2Texture_ST.xy + _Alpha2Texture_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _AlphaTextureScrollSpeedU;
uniform 	mediump float _AlphaTextureScrollSpeedV;
uniform 	float _effectStart;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTexture;
uniform lowp sampler2D _Alpha2Texture;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
vec2 u_xlat3;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
void main()
{
    u_xlat0.x = booster_Env.x + (-_effectStart);
    u_xlat3.xy = u_xlat0.xx * vec2(_AlphaTextureScrollSpeedU, _AlphaTextureScrollSpeedV);
    u_xlat0.xw = u_xlat0.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat0.xw = fract(u_xlat0.xw);
    u_xlat0.xw = u_xlat0.xw + vs_TEXCOORD0.xy;
    u_xlat10_1.xyz = texture2D(_MainTex, u_xlat0.xw).xyz;
    u_xlat0.xy = fract(u_xlat3.xy);
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD1.xy;
    u_xlat10_0 = texture2D(_AlphaTexture, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat10_0) + 1.0;
    u_xlat2 = vs_COLOR0 * _Color;
    u_xlat0.x = u_xlat16_0 * u_xlat2.w;
    SV_Target0.xyz = u_xlat10_1.xyz * u_xlat2.xyz;
    u_xlat10_3 = texture2D(_Alpha2Texture, vs_TEXCOORD5.xy).x;
    u_xlat16_3 = (-u_xlat10_3) + 1.0;
    SV_Target0.w = u_xlat16_3 * u_xlat0.x;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
}
}
}
}