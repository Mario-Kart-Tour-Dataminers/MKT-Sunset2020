//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/StandardCustom/水/WaterWave_AlphaUVWave" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_TransparencyLM ("AlphaMask(UV0)", 2D) = "black" { }
[Header(AlphaMask UV Wave)] _AlphaMaskScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_AlphaMaskScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
_AlphaMaskScrollSinScaleU ("U方向：波打つ幅", Range(-10, 10)) = 0
_AlphaMaskScrollSinScaleV ("V方向：波打つ幅", Range(-10, 10)) = 0
_AlphaMaskScrollSinSpeedU ("U方向：波打つ速度", Range(0, 10)) = 0
_AlphaMaskScrollSinSpeedV ("V方向：波打つ速度", Range(0, 10)) = 0
[Space(10)] _Metallic ("Metallic", Range(0, 1)) = 0
_Smoothness ("Smoothness", Range(0, 1)) = 0
_Occlusion ("Occlusion", Range(0, 1)) = 1
[Header(Vertex Wave Animation)] _WaveFreq ("波打つ頻度", Range(0, 10)) = 1
_WaveSpeed ("波打つ速度", Range(-100, 100)) = 1
_WaveHeight ("波の高さ", Range(0, 100)) = 1
_Wave2Freq ("波打つ頻度2", Range(0, 10)) = 1
_Wave2Speed ("波打つ速度2", Range(-100, 100)) = 1
_Wave2Height ("波の高さ2", Range(0, 100)) = 0
_WaveSlopeMag ("法線の傾きの強さ", Range(0, 1)) = 1
_WaveCenterPos ("波紋の中心", Vector) = (0,0,0,0)
[Header(Booster Reflection Cube Map)] [KeywordEnum(NO,YES,FIXEDCOLOR)] _ReflectionProbeType ("個別リフレクションキューブマップ使用", Float) = 0
_HeuristicReflection ("個別リフレクションキューブマップ", Cube) = "_Skybox" { }
_NormalDiff ("疑似LOD反射の揺らぎ", Range(-1, 1)) = 0
_NormalRand ("疑似LOD乱数値", Vector) = (9993.169,5715.817,4488.509,34.2347)
_FixedReflColor ("単色リフレクションカラー", Color) = (1,1,1,1)
[Space(20)] [Enum(NO,0,YES,2)] _StencilOp ("置き影が落ちなくなる", Float) = 0
}
SubShader {
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 50231
Program "vp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat5 = (-u_xlat15) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat15) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<u_xlat15);
#else
    u_xlatb10 = 0.0<u_xlat15;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * _Wave2Height;
    u_xlat15 = u_xlat4.x * _Wave2Height;
    u_xlat15 = _WaveHeight * u_xlat2.x + u_xlat15;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat5;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat15 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xy = vec2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
float u_xlat24;
bool u_xlatb24;
float u_xlat26;
mediump float u_xlat16_28;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24<9.99999975e-06);
#else
    u_xlatb24 = u_xlat24<9.99999975e-06;
#endif
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat2.z = u_xlat24 * u_xlat16_1.x;
    u_xlat3.x = u_xlat24 * u_xlat16_1.z;
    u_xlat2.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat3.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat3.z<0.00499999989);
#else
    u_xlatb24 = u_xlat3.z<0.00499999989;
#endif
    u_xlat26 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb24) ? 0.0 : u_xlat26;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_4.x = u_xlat16_1.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat24 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * vs_TEXCOORD1.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat24)) + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat24) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = (-u_xlat26) + 1.0;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_29 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_29 = u_xlat16_29 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.xyz = vec3(u_xlat16_29) + (-u_xlat16_6.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat0.xxx * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz * vec3(u_xlat16_28) + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat0.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat2.x = u_xlat0.x * _AlphaMaskScrollSinScaleU;
    u_xlat2.y = u_xlat0.y * _AlphaMaskScrollSinScaleV;
    u_xlat0.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat2.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_TransparencyLM, u_xlat0.xy).x;
    u_xlat16_0 = (-u_xlat16_0) + 1.0;
    SV_Target0.w = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat5 = (-u_xlat15) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat15) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<u_xlat15);
#else
    u_xlatb10 = 0.0<u_xlat15;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * _Wave2Height;
    u_xlat15 = u_xlat4.x * _Wave2Height;
    u_xlat15 = _WaveHeight * u_xlat2.x + u_xlat15;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat5;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat15 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xy = vec2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_14;
float u_xlat16;
float u_xlat24;
float u_xlat27;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat9.xyz = u_xlat8.xyz * u_xlat1.xxx;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat9.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat9.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat27 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat27;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_29 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_29);
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat9.x = dot(u_xlat3.xyz, u_xlat9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat16_29 = (-u_xlat9.x) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_6 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_14.x = (-u_xlat16_6) + _Smoothness;
    u_xlat16_14.x = u_xlat16_14.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14.x = min(max(u_xlat16_14.x, 0.0), 1.0);
#else
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_9.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_14.xyz = u_xlat16_14.xxx + (-u_xlat16_7.xyz);
    u_xlat16_14.xyz = vec3(u_xlat16_29) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_14.xyz;
    u_xlat27 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat27);
    u_xlat27 = dot(_WorldSpaceLightPos0.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat16 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat24 = max(u_xlat27, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat24;
    u_xlat24 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat8.x = u_xlat8.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyw = u_xlat16_9.xyz * vec3(u_xlat16_6) + u_xlat0.xyw;
    u_xlat0.xyw = u_xlat0.xyw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * vec3(u_xlat16) + u_xlat16_5.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat5 = (-u_xlat15) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat15) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<u_xlat15);
#else
    u_xlatb10 = 0.0<u_xlat15;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * _Wave2Height;
    u_xlat15 = u_xlat4.x * _Wave2Height;
    u_xlat15 = _WaveHeight * u_xlat2.x + u_xlat15;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat5;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat15 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xy = vec2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_14;
float u_xlat16;
float u_xlat24;
float u_xlat27;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat9.xyz = u_xlat8.xyz * u_xlat1.xxx;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat9.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat9.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat27 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat27;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_29 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_29);
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat9.x = dot(u_xlat3.xyz, u_xlat9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat16_29 = (-u_xlat9.x) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_6 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_14.x = (-u_xlat16_6) + _Smoothness;
    u_xlat16_14.x = u_xlat16_14.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14.x = min(max(u_xlat16_14.x, 0.0), 1.0);
#else
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_9.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_14.xyz = u_xlat16_14.xxx + (-u_xlat16_7.xyz);
    u_xlat16_14.xyz = vec3(u_xlat16_29) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_14.xyz;
    u_xlat27 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat27);
    u_xlat27 = dot(_WorldSpaceLightPos0.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat16 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat24 = max(u_xlat27, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat24;
    u_xlat24 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat8.x = u_xlat8.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyw = u_xlat16_9.xyz * vec3(u_xlat16_6) + u_xlat0.xyw;
    u_xlat0.xyw = u_xlat0.xyw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * vec3(u_xlat16) + u_xlat16_5.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat14;
bool u_xlatb14;
float u_xlat21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat7 = (-u_xlat21) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat21) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.0<u_xlat21);
#else
    u_xlatb14 = 0.0<u_xlat21;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * _Wave2Height;
    u_xlat21 = u_xlat4.x * _Wave2Height;
    u_xlat21 = _WaveHeight * u_xlat2.x + u_xlat21;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat7;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat21 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xy = vec2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_5 = u_xlat0.y * u_xlat0.y;
    u_xlat16_5 = u_xlat0.x * u_xlat0.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_31 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_31 = u_xlat16_31 + u_xlat16_31;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_31)) + (-u_xlat0.xyz);
    u_xlat30 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat30<9.99999975e-06);
#else
    u_xlatb30 = u_xlat30<9.99999975e-06;
#endif
    u_xlat30 = (u_xlatb30) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat30 * u_xlat16_2.x;
    u_xlat4.x = u_xlat30 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat30) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat4.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb30 = u_xlat4.z<0.00499999989;
#endif
    u_xlat33 = u_xlat4.z * 8.29800034;
    u_xlat16_31 = (u_xlatb30) ? 0.0 : u_xlat33;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_31);
    u_xlat16_31 = u_xlat16_2.w + -1.0;
    u_xlat16_31 = unity_SpecCube0_HDR.w * u_xlat16_31 + 1.0;
    u_xlat16_31 = u_xlat16_31 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_31);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat30 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * vs_TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat33 = u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat30)) + u_xlat0.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat30) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_31 = (-u_xlat33) + 1.0;
    u_xlat16_10 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_10 = u_xlat16_31 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_31 * u_xlat16_10;
    u_xlat16_31 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_35 = (-u_xlat16_31) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_31) * u_xlat16_3.xyz;
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_9.xyz = vec3(u_xlat16_35) + (-u_xlat16_7.xyz);
    u_xlat16_9.xyz = vec3(u_xlat16_10) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat3.x = u_xlat0.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat0.y * _AlphaMaskScrollSinScaleV;
    u_xlat0.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
    u_xlat16_0.x = texture(_TransparencyLM, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    SV_Target0.w = u_xlat16_0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat14;
bool u_xlatb14;
float u_xlat21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat7 = (-u_xlat21) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat21) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.0<u_xlat21);
#else
    u_xlatb14 = 0.0<u_xlat21;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * _Wave2Height;
    u_xlat21 = u_xlat4.x * _Wave2Height;
    u_xlat21 = _WaveHeight * u_xlat2.x + u_xlat21;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat7;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat21 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xy = vec2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_5 = u_xlat0.y * u_xlat0.y;
    u_xlat16_5 = u_xlat0.x * u_xlat0.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_10.xyz * vec3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat14;
bool u_xlatb14;
float u_xlat21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat7 = (-u_xlat21) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat21) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.0<u_xlat21);
#else
    u_xlatb14 = 0.0<u_xlat21;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * _Wave2Height;
    u_xlat21 = u_xlat4.x * _Wave2Height;
    u_xlat21 = _WaveHeight * u_xlat2.x + u_xlat21;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat7;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat21 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xy = vec2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_5 = u_xlat0.y * u_xlat0.y;
    u_xlat16_5 = u_xlat0.x * u_xlat0.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_10.xyz * vec3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat14;
bool u_xlatb14;
float u_xlat21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat7 = (-u_xlat21) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat21) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.0<u_xlat21);
#else
    u_xlatb14 = 0.0<u_xlat21;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * _Wave2Height;
    u_xlat21 = u_xlat4.x * _Wave2Height;
    u_xlat21 = _WaveHeight * u_xlat2.x + u_xlat21;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat7;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat21 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xy = vec2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_5 = u_xlat0.y * u_xlat0.y;
    u_xlat16_5 = u_xlat0.x * u_xlat0.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_28 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_28 = u_xlat16_28 + u_xlat16_28;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_28)) + (-u_xlat0.xyz);
    u_xlat27 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat27<9.99999975e-06);
#else
    u_xlatb27 = u_xlat27<9.99999975e-06;
#endif
    u_xlat27 = (u_xlatb27) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat27 * u_xlat16_2.x;
    u_xlat4.x = u_xlat27 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat27 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat16_2.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat4.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb27 = u_xlat4.z<0.00499999989;
#endif
    u_xlat30 = u_xlat4.z * 8.29800034;
    u_xlat16_28 = (u_xlatb27) ? 0.0 : u_xlat30;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_28);
    u_xlat16_28 = u_xlat16_2.w + -1.0;
    u_xlat16_28 = unity_SpecCube0_HDR.w * u_xlat16_28 + 1.0;
    u_xlat16_28 = u_xlat16_28 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_28);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat27 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * vs_TEXCOORD1.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat30 = u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat27)) + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = (-u_xlat30) + 1.0;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_32 = u_xlat16_32 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_32) + (-u_xlat16_6.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat16_5.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_28 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_28) * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat0.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat3.x = u_xlat0.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat0.y * _AlphaMaskScrollSinScaleV;
    u_xlat0.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
    u_xlat16_0.x = texture(_TransparencyLM, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    SV_Target0.w = u_xlat16_0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat14;
bool u_xlatb14;
float u_xlat21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat7 = (-u_xlat21) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat21) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.0<u_xlat21);
#else
    u_xlatb14 = 0.0<u_xlat21;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * _Wave2Height;
    u_xlat21 = u_xlat4.x * _Wave2Height;
    u_xlat21 = _WaveHeight * u_xlat2.x + u_xlat21;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat7;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat21 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xy = vec2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_5 = u_xlat0.y * u_xlat0.y;
    u_xlat16_5 = u_xlat0.x * u_xlat0.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_10.xyz * vec3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat14;
bool u_xlatb14;
float u_xlat21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat7 = (-u_xlat21) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat21) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.0<u_xlat21);
#else
    u_xlatb14 = 0.0<u_xlat21;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * _Wave2Height;
    u_xlat21 = u_xlat4.x * _Wave2Height;
    u_xlat21 = _WaveHeight * u_xlat2.x + u_xlat21;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat7;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat21 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xy = vec2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_5 = u_xlat0.y * u_xlat0.y;
    u_xlat16_5 = u_xlat0.x * u_xlat0.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_10.xyz * vec3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat5 = (-u_xlat15) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat15) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<u_xlat15);
#else
    u_xlatb10 = 0.0<u_xlat15;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * _Wave2Height;
    u_xlat15 = u_xlat4.x * _Wave2Height;
    u_xlat15 = _WaveHeight * u_xlat2.x + u_xlat15;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat5;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat15 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xy = vec2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
mediump float u_xlat16_31;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat27 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat27<9.99999975e-06);
#else
    u_xlatb27 = u_xlat27<9.99999975e-06;
#endif
    u_xlat27 = (u_xlatb27) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat2.z = u_xlat27 * u_xlat16_1.x;
    u_xlat3.x = u_xlat27 * u_xlat16_1.z;
    u_xlat2.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat27 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat16_1.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat3.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat3.z<0.00499999989);
#else
    u_xlatb27 = u_xlat3.z<0.00499999989;
#endif
    u_xlat29 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? 0.0 : u_xlat29;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_4.x = u_xlat16_1.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat27 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD1.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat29 = u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlat29 = min(max(u_xlat29, 0.0), 1.0);
#else
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
#endif
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat27)) + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_31 = (-u_xlat29) + 1.0;
    u_xlat16_9 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_9 = u_xlat16_31 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_31 * u_xlat16_9;
    u_xlat16_31 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_31) + _Smoothness;
    u_xlat16_32 = u_xlat16_32 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz;
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_32) + (-u_xlat16_6.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_8.xyz * u_xlat16_7.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat0.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat2.x = u_xlat0.x * _AlphaMaskScrollSinScaleU;
    u_xlat2.y = u_xlat0.y * _AlphaMaskScrollSinScaleV;
    u_xlat0.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat2.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
    u_xlat16_0.x = texture(_TransparencyLM, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    SV_Target0.w = u_xlat16_0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat5 = (-u_xlat15) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat15) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<u_xlat15);
#else
    u_xlatb10 = 0.0<u_xlat15;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * _Wave2Height;
    u_xlat15 = u_xlat4.x * _Wave2Height;
    u_xlat15 = _WaveHeight * u_xlat2.x + u_xlat15;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat5;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat15 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xy = vec2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_10.xyz * vec3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat5 = (-u_xlat15) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat15) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<u_xlat15);
#else
    u_xlatb10 = 0.0<u_xlat15;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * _Wave2Height;
    u_xlat15 = u_xlat4.x * _Wave2Height;
    u_xlat15 = _WaveHeight * u_xlat2.x + u_xlat15;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat5;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat15 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xy = vec2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_10.xyz * vec3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat5 = (-u_xlat15) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat15) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<u_xlat15);
#else
    u_xlatb10 = 0.0<u_xlat15;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * _Wave2Height;
    u_xlat15 = u_xlat4.x * _Wave2Height;
    u_xlat15 = _WaveHeight * u_xlat2.x + u_xlat15;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat5;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat15 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xy = vec2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_13;
mediump float u_xlat16_30;
mediump float u_xlat16_32;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_0.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat3.xyz = vec3(u_xlat33) * u_xlat3.xyz;
    u_xlat16_30 = dot((-u_xlat3.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_30 = u_xlat16_30 + u_xlat16_30;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_30)) + (-u_xlat3.xyz);
    u_xlat33 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<9.99999975e-06);
#else
    u_xlatb33 = u_xlat33<9.99999975e-06;
#endif
    u_xlat33 = (u_xlatb33) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat16_2.x * u_xlat33;
    u_xlat5.x = u_xlat16_2.z * u_xlat33;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat33 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * _NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33) + u_xlat16_2.xyz;
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat5.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat5.z<0.00499999989);
#else
    u_xlatb33 = u_xlat5.z<0.00499999989;
#endif
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_30 = (u_xlatb33) ? 0.0 : u_xlat34;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat4.xyz, u_xlat16_30);
    u_xlat16_30 = u_xlat16_1.w + -1.0;
    u_xlat16_30 = unity_SpecCube0_HDR.w * u_xlat16_30 + 1.0;
    u_xlat16_30 = u_xlat16_30 * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(u_xlat16_30);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Occlusion);
    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
    u_xlat33 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat34 = u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat3.xyz = u_xlat4.xyz * (-vec3(u_xlat33)) + u_xlat3.xyz;
    u_xlat33 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat33) * _LightColor0.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat5.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = texture(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_30 = (-u_xlat34) + 1.0;
    u_xlat16_13 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_13 = u_xlat16_30 * u_xlat16_13;
    u_xlat16_13 = u_xlat16_30 * u_xlat16_13;
    u_xlat16_30 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_30) + _Smoothness;
    u_xlat16_32 = u_xlat16_32 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_9.xyz = vec3(u_xlat16_32) + (-u_xlat16_7.xyz);
    u_xlat16_9.xyz = vec3(u_xlat16_13) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat3.xxx * u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_9.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_8.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat3.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat3.xy = sin(u_xlat3.xy);
    u_xlat4.x = u_xlat3.x * _AlphaMaskScrollSinScaleU;
    u_xlat4.y = u_xlat3.y * _AlphaMaskScrollSinScaleV;
    u_xlat3.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat4.xy;
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD0.xy;
    u_xlat16_3.x = texture(_TransparencyLM, u_xlat3.xy).x;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    SV_Target0.w = u_xlat16_3.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat5 = (-u_xlat15) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat15) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<u_xlat15);
#else
    u_xlatb10 = 0.0<u_xlat15;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * _Wave2Height;
    u_xlat15 = u_xlat4.x * _Wave2Height;
    u_xlat15 = _WaveHeight * u_xlat2.x + u_xlat15;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat5;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat15 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xy = vec2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat1.xxx;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat39;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_12.xyz * vec3(u_xlat16_41);
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_41);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_41 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_41 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_41);
    u_xlat16_2 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_41) + u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_11.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat1.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat5 = (-u_xlat15) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat15) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<u_xlat15);
#else
    u_xlatb10 = 0.0<u_xlat15;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * _Wave2Height;
    u_xlat15 = u_xlat4.x * _Wave2Height;
    u_xlat15 = _WaveHeight * u_xlat2.x + u_xlat15;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat5;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat15 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xy = vec2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat1.xxx;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat39;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_12.xyz * vec3(u_xlat16_41);
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_41);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_41 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_41 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_41);
    u_xlat16_2 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_41) + u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_11.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat1.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat5 = (-u_xlat15) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat15) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<u_xlat15);
#else
    u_xlatb10 = 0.0<u_xlat15;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * _Wave2Height;
    u_xlat15 = u_xlat4.x * _Wave2Height;
    u_xlat15 = _WaveHeight * u_xlat2.x + u_xlat15;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat5;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat15 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xy = vec2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_13;
float u_xlat24;
bool u_xlatb24;
float u_xlat26;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24<9.99999975e-06);
#else
    u_xlatb24 = u_xlat24<9.99999975e-06;
#endif
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat2.z = u_xlat24 * u_xlat16_1.x;
    u_xlat3.x = u_xlat24 * u_xlat16_1.z;
    u_xlat2.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat3.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat3.z<0.00499999989);
#else
    u_xlatb24 = u_xlat3.z<0.00499999989;
#endif
    u_xlat26 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb24) ? 0.0 : u_xlat26;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_4.x = u_xlat16_1.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat24 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * vs_TEXCOORD1.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat24)) + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = (-u_xlat26) + 1.0;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.x = (-u_xlat16_28) + _Smoothness;
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_13.xyz = u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_2.xyz;
    u_xlat16_13.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_13.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.xyz = (-u_xlat16_13.xyz) + u_xlat16_5.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_13.xyz;
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_13.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_28 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_28) * _LightColor0.xyz;
    u_xlat16_6.xyz = vec3(u_xlat24) * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat0.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat2.x = u_xlat0.x * _AlphaMaskScrollSinScaleU;
    u_xlat2.y = u_xlat0.y * _AlphaMaskScrollSinScaleV;
    u_xlat0.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat2.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy + vs_TEXCOORD0.xy;
    u_xlat16_0.x = texture(_TransparencyLM, u_xlat0.xy).x;
    u_xlat16_0.x = (-u_xlat16_0.x) + 1.0;
    SV_Target0.w = u_xlat16_0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat5 = (-u_xlat15) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat15) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<u_xlat15);
#else
    u_xlatb10 = 0.0<u_xlat15;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * _Wave2Height;
    u_xlat15 = u_xlat4.x * _Wave2Height;
    u_xlat15 = _WaveHeight * u_xlat2.x + u_xlat15;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat5;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat15 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xy = vec2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_10.xyz * vec3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat5 = (-u_xlat15) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat15) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<u_xlat15);
#else
    u_xlatb10 = 0.0<u_xlat15;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * _Wave2Height;
    u_xlat15 = u_xlat4.x * _Wave2Height;
    u_xlat15 = _WaveHeight * u_xlat2.x + u_xlat15;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat5;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat15 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xy = vec2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_10.xyz * vec3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat5 = (-u_xlat15) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat15) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<u_xlat15);
#else
    u_xlatb10 = 0.0<u_xlat15;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * _Wave2Height;
    u_xlat15 = u_xlat4.x * _Wave2Height;
    u_xlat15 = _WaveHeight * u_xlat2.x + u_xlat15;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat5;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat15 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xy = vec2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_12;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_0.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat16_27 = dot((-u_xlat3.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_27)) + (-u_xlat3.xyz);
    u_xlat30 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat30<9.99999975e-06);
#else
    u_xlatb30 = u_xlat30<9.99999975e-06;
#endif
    u_xlat30 = (u_xlatb30) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat16_2.x * u_xlat30;
    u_xlat5.x = u_xlat16_2.z * u_xlat30;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat30) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz;
    u_xlat5.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat5.z<0.00499999989);
#else
    u_xlatb30 = u_xlat5.z<0.00499999989;
#endif
    u_xlat31 = u_xlat5.z * 8.29800034;
    u_xlat16_27 = (u_xlatb30) ? 0.0 : u_xlat31;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat4.xyz, u_xlat16_27);
    u_xlat16_27 = u_xlat16_1.w + -1.0;
    u_xlat16_27 = unity_SpecCube0_HDR.w * u_xlat16_27 + 1.0;
    u_xlat16_27 = u_xlat16_27 * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(u_xlat16_27);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Occlusion);
    u_xlat30 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat4.xyz = vec3(u_xlat30) * vs_TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat31 = u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat3.xyz = u_xlat4.xyz * (-vec3(u_xlat30)) + u_xlat3.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat5.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = texture(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_27 = (-u_xlat31) + 1.0;
    u_xlat16_12 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_12 = u_xlat16_27 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_27 * u_xlat16_12;
    u_xlat16_27 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_29 = (-u_xlat16_27) + _Smoothness;
    u_xlat16_29 = u_xlat16_29 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz;
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_29) + (-u_xlat16_6.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_12) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat3.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz + u_xlat16_2.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_27 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_27) * _LightColor0.xyz;
    u_xlat16_2.xyz = vec3(u_xlat30) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat3.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat3.xy = sin(u_xlat3.xy);
    u_xlat4.x = u_xlat3.x * _AlphaMaskScrollSinScaleU;
    u_xlat4.y = u_xlat3.y * _AlphaMaskScrollSinScaleV;
    u_xlat3.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat4.xy;
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD0.xy;
    u_xlat16_3.x = texture(_TransparencyLM, u_xlat3.xy).x;
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    SV_Target0.w = u_xlat16_3.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat5 = (-u_xlat15) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat15) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<u_xlat15);
#else
    u_xlatb10 = 0.0<u_xlat15;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * _Wave2Height;
    u_xlat15 = u_xlat4.x * _Wave2Height;
    u_xlat15 = _WaveHeight * u_xlat2.x + u_xlat15;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat5;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat15 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xy = vec2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat1.xxx;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat39;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_12.xyz * vec3(u_xlat16_41);
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_41);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_41 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_41) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_41 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_41 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_41);
    u_xlat16_2 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_41) + u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_11.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat1.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat5 = (-u_xlat15) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat15) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<u_xlat15);
#else
    u_xlatb10 = 0.0<u_xlat15;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * _Wave2Height;
    u_xlat15 = u_xlat4.x * _Wave2Height;
    u_xlat15 = _WaveHeight * u_xlat2.x + u_xlat15;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat5;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat15 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xy = vec2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat1.xxx;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat39;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_12.xyz * vec3(u_xlat16_41);
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_41);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_41 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_41) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_41 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_41 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_41);
    u_xlat16_2 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_41) + u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_11.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat1.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat6 = (-u_xlat18) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat18) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<u_xlat18);
#else
    u_xlatb12 = 0.0<u_xlat18;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * _Wave2Height;
    u_xlat18 = u_xlat4.x * _Wave2Height;
    u_xlat18 = _WaveHeight * u_xlat2.x + u_xlat18;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat6;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat18 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat18, u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xy = vec2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
float u_xlat24;
bool u_xlatb24;
float u_xlat26;
mediump float u_xlat16_28;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24<9.99999975e-06);
#else
    u_xlatb24 = u_xlat24<9.99999975e-06;
#endif
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat2.z = u_xlat24 * u_xlat16_1.x;
    u_xlat3.x = u_xlat24 * u_xlat16_1.z;
    u_xlat2.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat3.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat3.z<0.00499999989);
#else
    u_xlatb24 = u_xlat3.z<0.00499999989;
#endif
    u_xlat26 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb24) ? 0.0 : u_xlat26;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_4.x = u_xlat16_1.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat24 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * vs_TEXCOORD1.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat24)) + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat24) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = (-u_xlat26) + 1.0;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_29 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_29 = u_xlat16_29 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.xyz = vec3(u_xlat16_29) + (-u_xlat16_6.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat0.xxx * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz * vec3(u_xlat16_28) + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat16_0.xyz + unity_FogColor.xyz;
    u_xlat2.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat2.y * _AlphaMaskScrollSinScaleV;
    u_xlat2.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
    u_xlat16_2.x = texture(_TransparencyLM, u_xlat2.xy).x;
    u_xlat0.w = (-u_xlat16_2.x) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat6 = (-u_xlat18) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat18) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<u_xlat18);
#else
    u_xlatb12 = 0.0<u_xlat18;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * _Wave2Height;
    u_xlat18 = u_xlat4.x * _Wave2Height;
    u_xlat18 = _WaveHeight * u_xlat2.x + u_xlat18;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat6;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat18 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat18, u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xy = vec2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_14;
float u_xlat16;
float u_xlat24;
float u_xlat27;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat9.xyz = u_xlat8.xyz * u_xlat1.xxx;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat9.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat9.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat27 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat27;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_29 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_29);
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat9.x = dot(u_xlat3.xyz, u_xlat9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat16_29 = (-u_xlat9.x) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_6 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_14.x = (-u_xlat16_6) + _Smoothness;
    u_xlat16_14.x = u_xlat16_14.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14.x = min(max(u_xlat16_14.x, 0.0), 1.0);
#else
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_9.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_14.xyz = u_xlat16_14.xxx + (-u_xlat16_7.xyz);
    u_xlat16_14.xyz = vec3(u_xlat16_29) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_14.xyz;
    u_xlat27 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat27);
    u_xlat27 = dot(_WorldSpaceLightPos0.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat16 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat24 = max(u_xlat27, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat24;
    u_xlat24 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat8.x = u_xlat8.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyw = u_xlat16_9.xyz * vec3(u_xlat16_6) + u_xlat0.xyw;
    u_xlat0.xyw = u_xlat0.xyw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * vec3(u_xlat16) + u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat6 = (-u_xlat18) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat18) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<u_xlat18);
#else
    u_xlatb12 = 0.0<u_xlat18;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * _Wave2Height;
    u_xlat18 = u_xlat4.x * _Wave2Height;
    u_xlat18 = _WaveHeight * u_xlat2.x + u_xlat18;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat6;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat18 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat18, u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xy = vec2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_14;
float u_xlat16;
float u_xlat24;
float u_xlat27;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat9.xyz = u_xlat8.xyz * u_xlat1.xxx;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat9.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat9.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat27 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat27;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_29 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_29);
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat9.x = dot(u_xlat3.xyz, u_xlat9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat16_29 = (-u_xlat9.x) + 1.0;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_29 = u_xlat16_29 * u_xlat16_29;
    u_xlat16_6 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_14.x = (-u_xlat16_6) + _Smoothness;
    u_xlat16_14.x = u_xlat16_14.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14.x = min(max(u_xlat16_14.x, 0.0), 1.0);
#else
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_9.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_14.xyz = u_xlat16_14.xxx + (-u_xlat16_7.xyz);
    u_xlat16_14.xyz = vec3(u_xlat16_29) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_14.xyz;
    u_xlat27 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat27);
    u_xlat27 = dot(_WorldSpaceLightPos0.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat8.x = dot(u_xlat3.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat16 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat8.x = u_xlat8.x * u_xlat8.x;
    u_xlat24 = max(u_xlat27, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat24;
    u_xlat24 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat8.x = u_xlat8.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyw = u_xlat16_9.xyz * vec3(u_xlat16_6) + u_xlat0.xyw;
    u_xlat0.xyw = u_xlat0.xyw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * vec3(u_xlat16) + u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat14;
bool u_xlatb14;
float u_xlat21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat7 = (-u_xlat21) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat21) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.0<u_xlat21);
#else
    u_xlatb14 = 0.0<u_xlat21;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * _Wave2Height;
    u_xlat21 = u_xlat4.x * _Wave2Height;
    u_xlat21 = _WaveHeight * u_xlat2.x + u_xlat21;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat7;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat21 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat21 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat21, u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xy = vec2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_5 = u_xlat0.y * u_xlat0.y;
    u_xlat16_5 = u_xlat0.x * u_xlat0.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_31 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_31 = u_xlat16_31 + u_xlat16_31;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_31)) + (-u_xlat0.xyz);
    u_xlat30 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat30<9.99999975e-06);
#else
    u_xlatb30 = u_xlat30<9.99999975e-06;
#endif
    u_xlat30 = (u_xlatb30) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat30 * u_xlat16_2.x;
    u_xlat4.x = u_xlat30 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat30) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat4.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb30 = u_xlat4.z<0.00499999989;
#endif
    u_xlat33 = u_xlat4.z * 8.29800034;
    u_xlat16_31 = (u_xlatb30) ? 0.0 : u_xlat33;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_31);
    u_xlat16_31 = u_xlat16_2.w + -1.0;
    u_xlat16_31 = unity_SpecCube0_HDR.w * u_xlat16_31 + 1.0;
    u_xlat16_31 = u_xlat16_31 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_31);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat30 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * vs_TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat33 = u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat30)) + u_xlat0.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat30) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_31 = (-u_xlat33) + 1.0;
    u_xlat16_10 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_10 = u_xlat16_31 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_31 * u_xlat16_10;
    u_xlat16_31 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_35 = (-u_xlat16_31) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_31) * u_xlat16_3.xyz;
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_9.xyz = vec3(u_xlat16_35) + (-u_xlat16_7.xyz);
    u_xlat16_9.xyz = vec3(u_xlat16_10) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat16_0.xyz + unity_FogColor.xyz;
    u_xlat3.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat3.xy = sin(u_xlat3.xy);
    u_xlat4.x = u_xlat3.x * _AlphaMaskScrollSinScaleU;
    u_xlat4.y = u_xlat3.y * _AlphaMaskScrollSinScaleV;
    u_xlat3.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat4.xy;
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD0.xy;
    u_xlat16_3.x = texture(_TransparencyLM, u_xlat3.xy).x;
    u_xlat0.w = (-u_xlat16_3.x) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat14;
bool u_xlatb14;
float u_xlat21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat7 = (-u_xlat21) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat21) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.0<u_xlat21);
#else
    u_xlatb14 = 0.0<u_xlat21;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * _Wave2Height;
    u_xlat21 = u_xlat4.x * _Wave2Height;
    u_xlat21 = _WaveHeight * u_xlat2.x + u_xlat21;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat7;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat21 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat21 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat21, u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xy = vec2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_5 = u_xlat0.y * u_xlat0.y;
    u_xlat16_5 = u_xlat0.x * u_xlat0.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_10.xyz * vec3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat14;
bool u_xlatb14;
float u_xlat21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat7 = (-u_xlat21) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat21) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.0<u_xlat21);
#else
    u_xlatb14 = 0.0<u_xlat21;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * _Wave2Height;
    u_xlat21 = u_xlat4.x * _Wave2Height;
    u_xlat21 = _WaveHeight * u_xlat2.x + u_xlat21;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat7;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat21 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat21 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat21, u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xy = vec2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_5 = u_xlat0.y * u_xlat0.y;
    u_xlat16_5 = u_xlat0.x * u_xlat0.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_10.xyz * vec3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat14;
bool u_xlatb14;
float u_xlat21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat7 = (-u_xlat21) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat21) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.0<u_xlat21);
#else
    u_xlatb14 = 0.0<u_xlat21;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * _Wave2Height;
    u_xlat21 = u_xlat4.x * _Wave2Height;
    u_xlat21 = _WaveHeight * u_xlat2.x + u_xlat21;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat7;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat21 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat21 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat21, u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xy = vec2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_5 = u_xlat0.y * u_xlat0.y;
    u_xlat16_5 = u_xlat0.x * u_xlat0.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat27;
bool u_xlatb27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_28 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_28 = u_xlat16_28 + u_xlat16_28;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_28)) + (-u_xlat0.xyz);
    u_xlat27 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat27<9.99999975e-06);
#else
    u_xlatb27 = u_xlat27<9.99999975e-06;
#endif
    u_xlat27 = (u_xlatb27) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat27 * u_xlat16_2.x;
    u_xlat4.x = u_xlat27 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat27 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat16_2.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat4.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb27 = u_xlat4.z<0.00499999989;
#endif
    u_xlat30 = u_xlat4.z * 8.29800034;
    u_xlat16_28 = (u_xlatb27) ? 0.0 : u_xlat30;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_28);
    u_xlat16_28 = u_xlat16_2.w + -1.0;
    u_xlat16_28 = unity_SpecCube0_HDR.w * u_xlat16_28 + 1.0;
    u_xlat16_28 = u_xlat16_28 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_28);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat27 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * vs_TEXCOORD1.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat30 = u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat27)) + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = (-u_xlat30) + 1.0;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_28 * u_xlat16_9;
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_32 = u_xlat16_32 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_3.xyz;
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_32) + (-u_xlat16_6.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat16_5.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_28 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_28) * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + unity_FogColor.xyz;
    u_xlat3.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat3.xy = sin(u_xlat3.xy);
    u_xlat4.x = u_xlat3.x * _AlphaMaskScrollSinScaleU;
    u_xlat4.y = u_xlat3.y * _AlphaMaskScrollSinScaleV;
    u_xlat3.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat4.xy;
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD0.xy;
    u_xlat16_3.x = texture(_TransparencyLM, u_xlat3.xy).x;
    u_xlat0.w = (-u_xlat16_3.x) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat14;
bool u_xlatb14;
float u_xlat21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat7 = (-u_xlat21) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat21) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.0<u_xlat21);
#else
    u_xlatb14 = 0.0<u_xlat21;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * _Wave2Height;
    u_xlat21 = u_xlat4.x * _Wave2Height;
    u_xlat21 = _WaveHeight * u_xlat2.x + u_xlat21;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat7;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat21 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat21 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat21, u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xy = vec2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_5 = u_xlat0.y * u_xlat0.y;
    u_xlat16_5 = u_xlat0.x * u_xlat0.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_10.xyz * vec3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat14;
bool u_xlatb14;
float u_xlat21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat7 = (-u_xlat21) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat21) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.0<u_xlat21);
#else
    u_xlatb14 = 0.0<u_xlat21;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat7);
    u_xlat4.x = cos(u_xlat7);
    u_xlat7 = u_xlat3.x * _Wave2Height;
    u_xlat21 = u_xlat4.x * _Wave2Height;
    u_xlat21 = _WaveHeight * u_xlat2.x + u_xlat21;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat7;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat21 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat21 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat21, u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat21 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xy = vec2(u_xlat21) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb14)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_5 = u_xlat0.y * u_xlat0.y;
    u_xlat16_5 = u_xlat0.x * u_xlat0.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_10.xyz * vec3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat6 = (-u_xlat18) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat18) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<u_xlat18);
#else
    u_xlatb12 = 0.0<u_xlat18;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * _Wave2Height;
    u_xlat18 = u_xlat4.x * _Wave2Height;
    u_xlat18 = _WaveHeight * u_xlat2.x + u_xlat18;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat6;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat18 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat18, u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xy = vec2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
mediump float u_xlat16_31;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat27 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat27<9.99999975e-06);
#else
    u_xlatb27 = u_xlat27<9.99999975e-06;
#endif
    u_xlat27 = (u_xlatb27) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat2.z = u_xlat27 * u_xlat16_1.x;
    u_xlat3.x = u_xlat27 * u_xlat16_1.z;
    u_xlat2.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat27 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat27) + u_xlat16_1.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat3.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat3.z<0.00499999989);
#else
    u_xlatb27 = u_xlat3.z<0.00499999989;
#endif
    u_xlat29 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? 0.0 : u_xlat29;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_4.x = u_xlat16_1.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat27 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD1.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat29 = u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlat29 = min(max(u_xlat29, 0.0), 1.0);
#else
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
#endif
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat27)) + u_xlat0.xyz;
    u_xlat27 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_31 = (-u_xlat29) + 1.0;
    u_xlat16_9 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_9 = u_xlat16_31 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_31 * u_xlat16_9;
    u_xlat16_31 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_31) + _Smoothness;
    u_xlat16_32 = u_xlat16_32 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_2.xyz;
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_32) + (-u_xlat16_6.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_8.xyz * u_xlat16_7.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + unity_FogColor.xyz;
    u_xlat2.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat2.y * _AlphaMaskScrollSinScaleV;
    u_xlat2.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
    u_xlat16_2.x = texture(_TransparencyLM, u_xlat2.xy).x;
    u_xlat0.w = (-u_xlat16_2.x) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat6 = (-u_xlat18) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat18) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<u_xlat18);
#else
    u_xlatb12 = 0.0<u_xlat18;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * _Wave2Height;
    u_xlat18 = u_xlat4.x * _Wave2Height;
    u_xlat18 = _WaveHeight * u_xlat2.x + u_xlat18;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat6;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat18 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat18, u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xy = vec2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_10.xyz * vec3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat6 = (-u_xlat18) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat18) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<u_xlat18);
#else
    u_xlatb12 = 0.0<u_xlat18;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * _Wave2Height;
    u_xlat18 = u_xlat4.x * _Wave2Height;
    u_xlat18 = _WaveHeight * u_xlat2.x + u_xlat18;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat6;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat18 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat18, u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xy = vec2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_10.xyz * vec3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat6 = (-u_xlat18) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat18) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<u_xlat18);
#else
    u_xlatb12 = 0.0<u_xlat18;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * _Wave2Height;
    u_xlat18 = u_xlat4.x * _Wave2Height;
    u_xlat18 = _WaveHeight * u_xlat2.x + u_xlat18;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat6;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat18 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat18, u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xy = vec2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_13;
mediump float u_xlat16_30;
mediump float u_xlat16_32;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_0.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat3.xyz = vec3(u_xlat33) * u_xlat3.xyz;
    u_xlat16_30 = dot((-u_xlat3.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_30 = u_xlat16_30 + u_xlat16_30;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_30)) + (-u_xlat3.xyz);
    u_xlat33 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<9.99999975e-06);
#else
    u_xlatb33 = u_xlat33<9.99999975e-06;
#endif
    u_xlat33 = (u_xlatb33) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat16_2.x * u_xlat33;
    u_xlat5.x = u_xlat16_2.z * u_xlat33;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat33 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * _NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33) + u_xlat16_2.xyz;
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat5.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat5.z<0.00499999989);
#else
    u_xlatb33 = u_xlat5.z<0.00499999989;
#endif
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_30 = (u_xlatb33) ? 0.0 : u_xlat34;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat4.xyz, u_xlat16_30);
    u_xlat16_30 = u_xlat16_1.w + -1.0;
    u_xlat16_30 = unity_SpecCube0_HDR.w * u_xlat16_30 + 1.0;
    u_xlat16_30 = u_xlat16_30 * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(u_xlat16_30);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Occlusion);
    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
    u_xlat33 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat34 = u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat34 = min(max(u_xlat34, 0.0), 1.0);
#else
    u_xlat34 = clamp(u_xlat34, 0.0, 1.0);
#endif
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat3.xyz = u_xlat4.xyz * (-vec3(u_xlat33)) + u_xlat3.xyz;
    u_xlat33 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat33) * _LightColor0.xyz;
    u_xlat3.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat5.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = texture(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_30 = (-u_xlat34) + 1.0;
    u_xlat16_13 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_13 = u_xlat16_30 * u_xlat16_13;
    u_xlat16_13 = u_xlat16_30 * u_xlat16_13;
    u_xlat16_30 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_30) + _Smoothness;
    u_xlat16_32 = u_xlat16_32 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_9.xyz = vec3(u_xlat16_32) + (-u_xlat16_7.xyz);
    u_xlat16_9.xyz = vec3(u_xlat16_13) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat3.xxx * u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_9.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat16_3.xyz + unity_FogColor.xyz;
    u_xlat3.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat3.xy = sin(u_xlat3.xy);
    u_xlat4.x = u_xlat3.x * _AlphaMaskScrollSinScaleU;
    u_xlat4.y = u_xlat3.y * _AlphaMaskScrollSinScaleV;
    u_xlat3.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat4.xy;
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD0.xy;
    u_xlat16_3.x = texture(_TransparencyLM, u_xlat3.xy).x;
    u_xlat0.w = (-u_xlat16_3.x) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat6 = (-u_xlat18) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat18) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<u_xlat18);
#else
    u_xlatb12 = 0.0<u_xlat18;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * _Wave2Height;
    u_xlat18 = u_xlat4.x * _Wave2Height;
    u_xlat18 = _WaveHeight * u_xlat2.x + u_xlat18;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat6;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat18 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat18, u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xy = vec2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat1.xxx;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat39;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_12.xyz * vec3(u_xlat16_41);
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_41);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_41 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_41 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_41);
    u_xlat16_2 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_41) + u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_11.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat1.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat6 = (-u_xlat18) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat18) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<u_xlat18);
#else
    u_xlatb12 = 0.0<u_xlat18;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * _Wave2Height;
    u_xlat18 = u_xlat4.x * _Wave2Height;
    u_xlat18 = _WaveHeight * u_xlat2.x + u_xlat18;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat6;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat18 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat18, u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xy = vec2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat1.xxx;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat39;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_12.xyz * vec3(u_xlat16_41);
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_41);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_41 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_41 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_41);
    u_xlat16_2 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_41) + u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_11.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat1.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat6 = (-u_xlat18) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat18) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<u_xlat18);
#else
    u_xlatb12 = 0.0<u_xlat18;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * _Wave2Height;
    u_xlat18 = u_xlat4.x * _Wave2Height;
    u_xlat18 = _WaveHeight * u_xlat2.x + u_xlat18;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat6;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat18 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat18, u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xy = vec2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_13;
float u_xlat24;
bool u_xlatb24;
float u_xlat26;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat24 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat24<9.99999975e-06);
#else
    u_xlatb24 = u_xlat24<9.99999975e-06;
#endif
    u_xlat24 = (u_xlatb24) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat2.z = u_xlat24 * u_xlat16_1.x;
    u_xlat3.x = u_xlat24 * u_xlat16_1.z;
    u_xlat2.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat24) + u_xlat16_1.xyz;
    u_xlat24 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat2.xyz;
    u_xlat3.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlat3.z<0.00499999989);
#else
    u_xlatb24 = u_xlat3.z<0.00499999989;
#endif
    u_xlat26 = u_xlat3.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb24) ? 0.0 : u_xlat26;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_4.x = u_xlat16_1.w + -1.0;
    u_xlat16_4.x = unity_SpecCube0_HDR.w * u_xlat16_4.x + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_4.xxx;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat24 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * vs_TEXCOORD1.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat26 = u_xlat24;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat24)) + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = (-u_xlat26) + 1.0;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_5.x = (-u_xlat16_28) + _Smoothness;
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_13.xyz = u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_2.xyz;
    u_xlat16_13.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_13.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.xyz = (-u_xlat16_13.xyz) + u_xlat16_5.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_13.xyz;
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_13.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_28 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_28) * _LightColor0.xyz;
    u_xlat16_6.xyz = vec3(u_xlat24) * u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat16_0.xyz + unity_FogColor.xyz;
    u_xlat2.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat3.x = u_xlat2.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat2.y * _AlphaMaskScrollSinScaleV;
    u_xlat2.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
    u_xlat16_2.x = texture(_TransparencyLM, u_xlat2.xy).x;
    u_xlat0.w = (-u_xlat16_2.x) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat6 = (-u_xlat18) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat18) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<u_xlat18);
#else
    u_xlatb12 = 0.0<u_xlat18;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * _Wave2Height;
    u_xlat18 = u_xlat4.x * _Wave2Height;
    u_xlat18 = _WaveHeight * u_xlat2.x + u_xlat18;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat6;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat18 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat18, u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xy = vec2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_10.xyz * vec3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat6 = (-u_xlat18) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat18) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<u_xlat18);
#else
    u_xlatb12 = 0.0<u_xlat18;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * _Wave2Height;
    u_xlat18 = u_xlat4.x * _Wave2Height;
    u_xlat18 = _WaveHeight * u_xlat2.x + u_xlat18;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat6;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat18 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat18, u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xy = vec2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
float u_xlat20;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat10.xyz * u_xlat1.xxx;
    u_xlat10.xyz = u_xlat10.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat33 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat33;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat20 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_10.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_10.xyz * vec3(u_xlat16_35);
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat6 = (-u_xlat18) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat18) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<u_xlat18);
#else
    u_xlatb12 = 0.0<u_xlat18;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * _Wave2Height;
    u_xlat18 = u_xlat4.x * _Wave2Height;
    u_xlat18 = _WaveHeight * u_xlat2.x + u_xlat18;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat6;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat18 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat18, u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xy = vec2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_12;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
float u_xlat30;
bool u_xlatb30;
float u_xlat31;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_0.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_0.xyz = u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat16_27 = dot((-u_xlat3.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_27)) + (-u_xlat3.xyz);
    u_xlat30 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat30<9.99999975e-06);
#else
    u_xlatb30 = u_xlat30<9.99999975e-06;
#endif
    u_xlat30 = (u_xlatb30) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat16_2.x * u_xlat30;
    u_xlat5.x = u_xlat16_2.z * u_xlat30;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat30) + u_xlat16_2.xyz;
    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz;
    u_xlat5.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat5.z<0.00499999989);
#else
    u_xlatb30 = u_xlat5.z<0.00499999989;
#endif
    u_xlat31 = u_xlat5.z * 8.29800034;
    u_xlat16_27 = (u_xlatb30) ? 0.0 : u_xlat31;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat4.xyz, u_xlat16_27);
    u_xlat16_27 = u_xlat16_1.w + -1.0;
    u_xlat16_27 = unity_SpecCube0_HDR.w * u_xlat16_27 + 1.0;
    u_xlat16_27 = u_xlat16_27 * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(u_xlat16_27);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Occlusion);
    u_xlat30 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat4.xyz = vec3(u_xlat30) * vs_TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat4.xyz);
    u_xlat31 = u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat3.xyz = u_xlat4.xyz * (-vec3(u_xlat30)) + u_xlat3.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat3.x = u_xlat3.x * u_xlat3.x;
    u_xlat5.x = u_xlat3.x * u_xlat3.x;
    u_xlat3.x = texture(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_27 = (-u_xlat31) + 1.0;
    u_xlat16_12 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_12 = u_xlat16_27 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_27 * u_xlat16_12;
    u_xlat16_27 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_29 = (-u_xlat16_27) + _Smoothness;
    u_xlat16_29 = u_xlat16_29 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz;
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_29) + (-u_xlat16_6.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_12) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat3.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz + u_xlat16_2.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_27 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_27) * _LightColor0.xyz;
    u_xlat16_2.xyz = vec3(u_xlat30) * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat16_3.xyz + unity_FogColor.xyz;
    u_xlat3.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat3.xy = sin(u_xlat3.xy);
    u_xlat4.x = u_xlat3.x * _AlphaMaskScrollSinScaleU;
    u_xlat4.y = u_xlat3.y * _AlphaMaskScrollSinScaleV;
    u_xlat3.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat4.xy;
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD0.xy;
    u_xlat16_3.x = texture(_TransparencyLM, u_xlat3.xy).x;
    u_xlat0.w = (-u_xlat16_3.x) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat6 = (-u_xlat18) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat18) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<u_xlat18);
#else
    u_xlatb12 = 0.0<u_xlat18;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * _Wave2Height;
    u_xlat18 = u_xlat4.x * _Wave2Height;
    u_xlat18 = _WaveHeight * u_xlat2.x + u_xlat18;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat6;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat18 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat18, u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xy = vec2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat1.xxx;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat39;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_12.xyz * vec3(u_xlat16_41);
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_41);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_41 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_41) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_41 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_41 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_41);
    u_xlat16_2 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_41) + u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_11.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat1.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _TransparencyLM_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat6 = (-u_xlat18) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat18) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<u_xlat18);
#else
    u_xlatb12 = 0.0<u_xlat18;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * _Wave2Height;
    u_xlat18 = u_xlat4.x * _Wave2Height;
    u_xlat18 = _WaveHeight * u_xlat2.x + u_xlat18;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat6;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat18 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat18, u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _TransparencyLM_ST.xy + _TransparencyLM_ST.zw;
    u_xlat0.y = 1.0;
    u_xlat18 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xy = vec2(u_xlat18) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD3.xy = u_xlat0.xy;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _AlphaMaskScrollSpeedU;
uniform 	mediump float _AlphaMaskScrollSpeedV;
uniform 	mediump float _AlphaMaskScrollSinScaleU;
uniform 	mediump float _AlphaMaskScrollSinScaleV;
uniform 	mediump float _AlphaMaskScrollSinSpeedU;
uniform 	mediump float _AlphaMaskScrollSinSpeedV;
uniform mediump sampler2D _TransparencyLM;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec2 u_xlat1;
mediump float u_xlat16_1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat1.xxx;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
    u_xlat1.x = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1.x * u_xlat16_2.x;
    u_xlat4.x = u_xlat1.x * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat3.xyz = u_xlat1.xxx * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat3.xyz = u_xlat3.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb1 = u_xlat0.x<0.00499999989;
#endif
    u_xlat39 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat39;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_41 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_41 = (-u_xlat16_41) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_41);
    u_xlat3.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat12.xyz = u_xlat12.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat24 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_41 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_12.xyz * vec3(u_xlat16_41);
    u_xlat16_41 = (-u_xlat16_41) + _Smoothness;
    u_xlat16_41 = u_xlat16_41 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_41);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_41 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_41 = min(max(u_xlat16_41, 0.0), 1.0);
#else
    u_xlat16_41 = clamp(u_xlat16_41, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_41) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_41 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_41 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_41);
    u_xlat16_2 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_2);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_2);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_2);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_41) + u_xlat16_9.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_11.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_11.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat1.x) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlphaMaskScrollSinSpeedU, _AlphaMaskScrollSinSpeedV);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat3.x = u_xlat1.x * _AlphaMaskScrollSinScaleU;
    u_xlat3.y = u_xlat1.y * _AlphaMaskScrollSinScaleV;
    u_xlat1.xy = vec2(_AlphaMaskScrollSpeedU, _AlphaMaskScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_TransparencyLM, u_xlat1.xy).x;
    u_xlat0.w = (-u_xlat16_1) + 1.0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 76716
Program "vp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat5 = (-u_xlat15) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat15) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<u_xlat15);
#else
    u_xlatb10 = 0.0<u_xlat15;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * _Wave2Height;
    u_xlat15 = u_xlat4.x * _Wave2Height;
    u_xlat15 = _WaveHeight * u_xlat2.x + u_xlat15;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat5;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat15 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xy = vec2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform highp sampler2D unity_NHxRoughness;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat1.xyz * (-vec3(u_xlat12)) + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = (-_Smoothness) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_4.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_14 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat5 = (-u_xlat15) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat15) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<u_xlat15);
#else
    u_xlatb10 = 0.0<u_xlat15;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * _Wave2Height;
    u_xlat15 = u_xlat4.x * _Wave2Height;
    u_xlat15 = _WaveHeight * u_xlat2.x + u_xlat15;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat5;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat15 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xy = vec2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
float u_xlat9;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1.x = (-_Smoothness) + 1.0;
    u_xlat16_4 = u_xlat16_1.x * u_xlat16_1.x + 1.5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat9 = u_xlat9 * u_xlat16_4;
    u_xlat4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = u_xlat16_1.x * u_xlat16_1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_6 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = u_xlat16_1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_1.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat16_1.xyz * u_xlat16_2.xxx + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xzw;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat5 = (-u_xlat15) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat15) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<u_xlat15);
#else
    u_xlatb10 = 0.0<u_xlat15;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat5);
    u_xlat4.x = cos(u_xlat5);
    u_xlat5 = u_xlat3.x * _Wave2Height;
    u_xlat15 = u_xlat4.x * _Wave2Height;
    u_xlat15 = _WaveHeight * u_xlat2.x + u_xlat15;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat5;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat15 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    u_xlat0.y = 1.0;
    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xy = vec2(u_xlat15) * u_xlat0.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb10)) ? u_xlat0.xyw : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
float u_xlat9;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1.x = (-_Smoothness) + 1.0;
    u_xlat16_4 = u_xlat16_1.x * u_xlat16_1.x + 1.5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat9 = u_xlat9 * u_xlat16_4;
    u_xlat4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = u_xlat16_1.x * u_xlat16_1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_6 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = u_xlat16_1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_1.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat16_1.xyz * u_xlat16_2.xxx + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xzw;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat6 = (-u_xlat18) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat18) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<u_xlat18);
#else
    u_xlatb12 = 0.0<u_xlat18;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * _Wave2Height;
    u_xlat18 = u_xlat4.x * _Wave2Height;
    u_xlat18 = _WaveHeight * u_xlat2.x + u_xlat18;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat6;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat18 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.y = 1.0;
    u_xlat2.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xy = u_xlat0.xy * u_xlat2.xx;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat18, u_xlat16_5);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform highp sampler2D unity_NHxRoughness;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat1.xyz * (-vec3(u_xlat12)) + u_xlat0.xyz;
    u_xlat12 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = (-_Smoothness) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_4.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_14 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.x = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat6 = (-u_xlat18) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat18) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<u_xlat18);
#else
    u_xlatb12 = 0.0<u_xlat18;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * _Wave2Height;
    u_xlat18 = u_xlat4.x * _Wave2Height;
    u_xlat18 = _WaveHeight * u_xlat2.x + u_xlat18;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat6;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat18 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.y = 1.0;
    u_xlat2.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xy = u_xlat0.xy * u_xlat2.xx;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat18, u_xlat16_5);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
float u_xlat9;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1.x = (-_Smoothness) + 1.0;
    u_xlat16_4 = u_xlat16_1.x * u_xlat16_1.x + 1.5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat9 = u_xlat9 * u_xlat16_4;
    u_xlat4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = u_xlat16_1.x * u_xlat16_1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_6 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = u_xlat16_1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_1.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat16_1.xyz * u_xlat16_2.xxx + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xzw;
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 booster_Env;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat18;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-_WaveCenterPos.xz);
    u_xlat12 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat18 = sqrt(u_xlat12);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat0.xy;
    u_xlat0.x = booster_Env.x * 0.0500000007;
    u_xlat0.xy = u_xlat0.xx * vec2(_WaveSpeed, _Wave2Speed);
    u_xlat6 = (-u_xlat18) * _Wave2Freq + u_xlat0.y;
    u_xlat0.x = (-u_xlat18) * _WaveFreq + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<u_xlat18);
#else
    u_xlatb12 = 0.0<u_xlat18;
#endif
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat6);
    u_xlat4.x = cos(u_xlat6);
    u_xlat6 = u_xlat3.x * _Wave2Height;
    u_xlat18 = u_xlat4.x * _Wave2Height;
    u_xlat18 = _WaveHeight * u_xlat2.x + u_xlat18;
    u_xlat0.x = _WaveHeight * u_xlat0.x + u_xlat6;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat2 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat2;
    u_xlat0.x = u_xlat18 * _WaveSlopeMag;
    u_xlat3 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat2 = u_xlat3.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat3.zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat3.wwww + u_xlat2;
    gl_Position = u_xlat2;
    u_xlat18 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.y = 1.0;
    u_xlat2.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xy = u_xlat0.xy * u_xlat2.xx;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.xyz = (bool(u_xlatb12)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat18, u_xlat16_5);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_4;
mediump float u_xlat16_6;
float u_xlat9;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9) + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = max(u_xlat9, 0.00100000005);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat9 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat9 = max(u_xlat9, 0.319999993);
    u_xlat16_1.x = (-_Smoothness) + 1.0;
    u_xlat16_4 = u_xlat16_1.x * u_xlat16_1.x + 1.5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat9 = u_xlat9 * u_xlat16_4;
    u_xlat4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_6 = u_xlat16_1.x * u_xlat16_1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_6 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = u_xlat16_1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_1.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat16_1.xyz * u_xlat16_2.xxx + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xzw;
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 0.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
""
}
}
}
}
Fallback "Booster/Black"
}