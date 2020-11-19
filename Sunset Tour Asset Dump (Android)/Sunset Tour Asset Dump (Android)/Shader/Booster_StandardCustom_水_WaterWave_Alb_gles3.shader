//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/StandardCustom/水/WaterWave_Alb" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("Albedo(UV0)", 2D) = "white" { }
[Header(Albedo UV Scroll)] _AlbedoScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_AlbedoScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
[Space(10)] _Metallic ("Metallic", Range(0, 1)) = 0
_Smoothness ("Smoothness", Range(0, 1)) = 0
_Occlusion ("Occlusion", Range(0, 1)) = 1
[Header(Booster Whitecaps)] _Whitecaps ("白波テクスチャRGB(UV0)", 2D) = "black" { }
_WhitecapsAlpha ("白波テクスチャA(UV0)", 2D) = "white" { }
[Header(Whitecaps UV Wave)] _WhitecapsScrollSpeedU ("U方向：移動速度", Range(-10, 10)) = 0
_WhitecapsScrollSpeedV ("V方向：移動速度", Range(-10, 10)) = 0
_WhitecapsScrollSinScaleU ("U方向：波打つ幅", Range(-10, 10)) = 0
_WhitecapsScrollSinScaleV ("V方向：波打つ幅", Range(-10, 10)) = 0
_WhitecapsScrollSinSpeedU ("U方向：波打つ速度", Range(0, 10)) = 0
_WhitecapsScrollSinSpeedV ("V方向：波打つ速度", Range(0, 10)) = 0
[Header(Whitecaps Parameters)] _WhitecapsBaseAlpha ("カメラ距離による透明度", Range(0, 1)) = 0.117647
_WhitecapsDepthMin ("透明が始まる距離", Range(0, 200)) = 10
_WhitecapsDepthMax ("透明が終わる距離", Range(0, 200)) = 50
[Space(10)] [Header(Vertex Wave Animation)] _WaveFreq ("波打つ頻度", Range(0, 10)) = 1
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
  GpuProgramID 28916
Program "vp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * _Wave2Freq;
    u_xlat5 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat5 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat10 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat15 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<u_xlat15);
#else
    u_xlatb15 = 0.0<u_xlat15;
#endif
    u_xlat5 = u_xlat5 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat5 = _WaveHeight * u_xlat3.x + u_xlat10;
    u_xlat2.x = u_xlat5 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat5 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
vec2 u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat18.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat18.xy = sin(u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat18.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat18.xy;
    u_xlat18.xy = fract(u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy + vs_TEXCOORD0.zw;
    u_xlat16_2.xyz = texture(_Whitecaps, u_xlat18.xy).xyz;
    u_xlat16_18 = texture(_WhitecapsAlpha, u_xlat18.xy).x;
    u_xlat16_18 = (-u_xlat16_18) + 1.0;
    u_xlat3.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_3.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_31 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_31) + _Smoothness;
    u_xlat16_32 = u_xlat16_32 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_32);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0 = (-u_xlat16_18) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_18;
    u_xlat16_9 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_9 * u_xlat16_1.w + u_xlat0.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * _Wave2Freq;
    u_xlat5 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat5 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat10 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat15 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<u_xlat15);
#else
    u_xlatb15 = 0.0<u_xlat15;
#endif
    u_xlat5 = u_xlat5 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat5 = _WaveHeight * u_xlat3.x + u_xlat10;
    u_xlat2.x = u_xlat5 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat5 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
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
vec3 u_xlat11;
mediump float u_xlat16_11;
float u_xlat20;
vec2 u_xlat21;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * vec3(u_xlat1);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1<9.99999975e-06;
#endif
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
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
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat11.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat11.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat11.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat11.xy;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = texture(_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + 1.0;
    u_xlat21.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat21.xy = fract(u_xlat21.xy);
    u_xlat21.xy = u_xlat21.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat21.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_37 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_38 = (-u_xlat16_37) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_38);
    u_xlat16_9.xyz = vec3(u_xlat16_35) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat21.x = max(u_xlat21.x, 0.00100000005);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat21.xxx;
    u_xlat21.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21.x = min(max(u_xlat21.x, 0.0), 1.0);
#else
    u_xlat21.x = clamp(u_xlat21.x, 0.0, 1.0);
#endif
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat20 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat30 = max(u_xlat21.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat30;
    u_xlat30 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat30 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = u_xlat16_8.xyz * u_xlat0.xxx;
    u_xlat0.xyw = u_xlat16_7.xyz * vec3(u_xlat16_37) + u_xlat0.xyw;
    u_xlat0.xyw = u_xlat0.xyw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * vec3(u_xlat20) + u_xlat16_5.xyz;
    u_xlat16_1 = (-u_xlat16_11) + 1.0;
    u_xlat1 = vs_TEXCOORD3 * u_xlat16_1 + u_xlat16_11;
    u_xlat16_11 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat1 = u_xlat16_11 * u_xlat16_2.w + u_xlat1;
    u_xlat0.w = min(u_xlat1, 1.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * _Wave2Freq;
    u_xlat5 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat5 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat10 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat15 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<u_xlat15);
#else
    u_xlatb15 = 0.0<u_xlat15;
#endif
    u_xlat5 = u_xlat5 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat5 = _WaveHeight * u_xlat3.x + u_xlat10;
    u_xlat2.x = u_xlat5 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat5 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
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
vec3 u_xlat11;
mediump float u_xlat16_11;
float u_xlat20;
vec2 u_xlat21;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * vec3(u_xlat1);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1<9.99999975e-06;
#endif
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
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
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat11.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat11.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat11.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat11.xy;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = texture(_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + 1.0;
    u_xlat21.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat21.xy = fract(u_xlat21.xy);
    u_xlat21.xy = u_xlat21.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat21.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_37 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_38 = (-u_xlat16_37) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_38);
    u_xlat16_9.xyz = vec3(u_xlat16_35) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat21.x = max(u_xlat21.x, 0.00100000005);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat21.xxx;
    u_xlat21.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21.x = min(max(u_xlat21.x, 0.0), 1.0);
#else
    u_xlat21.x = clamp(u_xlat21.x, 0.0, 1.0);
#endif
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat20 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat30 = max(u_xlat21.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat30;
    u_xlat30 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat30 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = u_xlat16_8.xyz * u_xlat0.xxx;
    u_xlat0.xyw = u_xlat16_7.xyz * vec3(u_xlat16_37) + u_xlat0.xyw;
    u_xlat0.xyw = u_xlat0.xyw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * vec3(u_xlat20) + u_xlat16_5.xyz;
    u_xlat16_1 = (-u_xlat16_11) + 1.0;
    u_xlat1 = vs_TEXCOORD3 * u_xlat16_1 + u_xlat16_11;
    u_xlat16_11 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat1 = u_xlat16_11 * u_xlat16_2.w + u_xlat1;
    u_xlat0.w = min(u_xlat1, 1.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7 = u_xlat7 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7);
    u_xlat3.x = cos(u_xlat7);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7 = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat7 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : in_NORMAL0.xyz;
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
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
vec2 u_xlat20;
mediump float u_xlat16_20;
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
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD4.xyz;
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
    u_xlat20.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat20.xy = sin(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat20.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat20.xy;
    u_xlat20.xy = fract(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy + vs_TEXCOORD0.zw;
    u_xlat16_3.xyz = texture(_Whitecaps, u_xlat20.xy).xyz;
    u_xlat16_20 = texture(_WhitecapsAlpha, u_xlat20.xy).x;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat4.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat4.xy);
    u_xlat16_4.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_31 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_35 = (-u_xlat16_31) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat16_31 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_31);
    u_xlat16_9.xyz = vec3(u_xlat16_10) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_8.xyz * u_xlat16_6.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = (-u_xlat16_20) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0.x + u_xlat16_20;
    u_xlat16_10 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_10 * u_xlat16_2.w + u_xlat0.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7 = u_xlat7 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7);
    u_xlat3.x = cos(u_xlat7);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7 = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat7 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : in_NORMAL0.xyz;
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
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec3 u_xlat12;
vec2 u_xlat22;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_38 = (-u_xlat16_38) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
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
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22.x + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat11.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat11.xy;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = texture(_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + 1.0;
    u_xlat22.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_38);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat4.xyz = vs_TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_10.xyz = u_xlat16_10.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat12.x) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat1.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat16_0 = (-u_xlat16_11) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_11;
    u_xlat16_11 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_11 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7 = u_xlat7 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7);
    u_xlat3.x = cos(u_xlat7);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7 = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat7 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : in_NORMAL0.xyz;
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
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec3 u_xlat12;
vec2 u_xlat22;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_38 = (-u_xlat16_38) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
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
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22.x + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat11.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat11.xy;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = texture(_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + 1.0;
    u_xlat22.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_38);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat4.xyz = vs_TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_10.xyz = u_xlat16_10.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat12.x) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat1.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat16_0 = (-u_xlat16_11) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_11;
    u_xlat16_11 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_11 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7 = u_xlat7 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7);
    u_xlat3.x = cos(u_xlat7);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7 = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat7 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : in_NORMAL0.xyz;
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
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
mediump float u_xlat16_18;
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
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD4.xyz;
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
    u_xlat3.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat3.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat3.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat3.xy).xyz;
    u_xlat16_18 = texture(_WhitecapsAlpha, u_xlat3.xy).x;
    u_xlat16_18 = (-u_xlat16_18) + 1.0;
    u_xlat3.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_3.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat16_28 = u_xlat16_32 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_28);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_3 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_28 = dot(u_xlat16_3, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_28) * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_0.x = (-u_xlat16_18) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0.x + u_xlat16_18;
    u_xlat16_9 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_9 * u_xlat16_2.w + u_xlat0.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7 = u_xlat7 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7);
    u_xlat3.x = cos(u_xlat7);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7 = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat7 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : in_NORMAL0.xyz;
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
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec3 u_xlat12;
vec2 u_xlat22;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_38 = (-u_xlat16_38) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
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
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22.x + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat11.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat11.xy;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = texture(_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + 1.0;
    u_xlat22.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_38);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_38 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = vec3(u_xlat16_38) * _LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat16_10.xyz;
    u_xlat4.xyz = vs_TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_10.xyz = u_xlat16_10.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat12.x) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat1.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat16_0 = (-u_xlat16_11) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_11;
    u_xlat16_11 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_11 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7 = u_xlat7 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7);
    u_xlat3.x = cos(u_xlat7);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7 = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat7 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat0.xyz : in_NORMAL0.xyz;
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
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec3 u_xlat12;
vec2 u_xlat22;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_38 = (-u_xlat16_38) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
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
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22.x + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat11.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat11.xy;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = texture(_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + 1.0;
    u_xlat22.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_38);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_38 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = vec3(u_xlat16_38) * _LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat16_10.xyz;
    u_xlat4.xyz = vs_TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_10.xyz = u_xlat16_10.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat12.x) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat1.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat16_0 = (-u_xlat16_11) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_11;
    u_xlat16_11 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_11 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * _Wave2Freq;
    u_xlat5 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat5 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat10 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat15 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<u_xlat15);
#else
    u_xlatb15 = 0.0<u_xlat15;
#endif
    u_xlat5 = u_xlat5 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat5 = _WaveHeight * u_xlat3.x + u_xlat10;
    u_xlat2.x = u_xlat5 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat5 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
vec2 u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat18.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat18.xy = sin(u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat18.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat18.xy;
    u_xlat18.xy = fract(u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy + vs_TEXCOORD0.zw;
    u_xlat16_2.xyz = texture(_Whitecaps, u_xlat18.xy).xyz;
    u_xlat16_18 = texture(_WhitecapsAlpha, u_xlat18.xy).x;
    u_xlat16_18 = (-u_xlat16_18) + 1.0;
    u_xlat3.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_3.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_31 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_31) + _Smoothness;
    u_xlat16_6.xyz = vec3(u_xlat16_31) * u_xlat16_6.xyz;
    u_xlat16_31 = u_xlat16_32 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_31);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyw = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyw * unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_8.xyz * u_xlat16_6.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.x = (-u_xlat16_18) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0.x + u_xlat16_18;
    u_xlat16_9 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_9 * u_xlat16_1.w + u_xlat0.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * _Wave2Freq;
    u_xlat5 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat5 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat10 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat15 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<u_xlat15);
#else
    u_xlatb15 = 0.0<u_xlat15;
#endif
    u_xlat5 = u_xlat5 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat5 = _WaveHeight * u_xlat3.x + u_xlat10;
    u_xlat2.x = u_xlat5 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat5 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
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
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec3 u_xlat12;
vec2 u_xlat22;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_38 = (-u_xlat16_38) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
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
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22.x + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat11.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat11.xy;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = texture(_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + 1.0;
    u_xlat22.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_38);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat12.x) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat1.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat16_0 = (-u_xlat16_11) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_11;
    u_xlat16_11 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_11 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * _Wave2Freq;
    u_xlat5 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat5 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat10 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat15 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<u_xlat15);
#else
    u_xlatb15 = 0.0<u_xlat15;
#endif
    u_xlat5 = u_xlat5 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat5 = _WaveHeight * u_xlat3.x + u_xlat10;
    u_xlat2.x = u_xlat5 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat5 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
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
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec3 u_xlat12;
vec2 u_xlat22;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_38 = (-u_xlat16_38) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
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
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22.x + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat11.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat11.xy;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = texture(_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + 1.0;
    u_xlat22.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_38);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat12.x) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat1.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat16_0 = (-u_xlat16_11) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_11;
    u_xlat16_11 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_11 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * _Wave2Freq;
    u_xlat5 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat5 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat10 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat15 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<u_xlat15);
#else
    u_xlatb15 = 0.0<u_xlat15;
#endif
    u_xlat5 = u_xlat5 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat5 = _WaveHeight * u_xlat3.x + u_xlat10;
    u_xlat2.x = u_xlat5 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat5 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
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
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_13;
vec2 u_xlat23;
mediump float u_xlat16_23;
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
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
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
    u_xlat23.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat23.xy = sin(u_xlat23.xy);
    u_xlat23.xy = u_xlat23.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat23.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat23.xy;
    u_xlat23.xy = fract(u_xlat23.xy);
    u_xlat23.xy = u_xlat23.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat23.xy).xyz;
    u_xlat16_23 = texture(_WhitecapsAlpha, u_xlat23.xy).x;
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat5.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat5.xy = u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_5.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_30 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_30) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_30) * u_xlat16_7.xyz;
    u_xlat16_30 = u_xlat16_32 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_30);
    u_xlat16_9.xyz = vec3(u_xlat16_13) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat3.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_9.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_8.xyz * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat16_3.x = (-u_xlat16_23) + 1.0;
    u_xlat3.x = vs_TEXCOORD3 * u_xlat16_3.x + u_xlat16_23;
    u_xlat16_13 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat3.x = u_xlat16_13 * u_xlat16_1.w + u_xlat3.x;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    SV_Target0.w = u_xlat3.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * _Wave2Freq;
    u_xlat5 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat5 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat10 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat15 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<u_xlat15);
#else
    u_xlatb15 = 0.0<u_xlat15;
#endif
    u_xlat5 = u_xlat5 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat5 = _WaveHeight * u_xlat3.x + u_xlat10;
    u_xlat2.x = u_xlat5 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat5 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
mediump float u_xlat16_13;
vec3 u_xlat14;
vec2 u_xlat26;
float u_xlat42;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat13.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat14.xyz = u_xlat13.xyz * u_xlat1.xxx;
    u_xlat13.xyz = u_xlat13.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat14.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat14.xyz);
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
    u_xlat42 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat42;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_44 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_44 = (-u_xlat16_44) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_44);
    u_xlat3.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat13.xyz = u_xlat13.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat13.xyz);
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
    u_xlat13.x = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
    u_xlat26.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat26.x + 1.00001001;
    u_xlat0.x = u_xlat13.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat13.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat13.xy = sin(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat13.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat13.xy;
    u_xlat13.xy = fract(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat13.xy).xyz;
    u_xlat16_13 = texture(_WhitecapsAlpha, u_xlat13.xy).x;
    u_xlat16_13 = (-u_xlat16_13) + 1.0;
    u_xlat26.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat26.xy = fract(u_xlat26.xy);
    u_xlat26.xy = u_xlat26.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat26.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_44 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_44) * u_xlat16_7.xyz;
    u_xlat16_44 = (-u_xlat16_44) + _Smoothness;
    u_xlat16_44 = u_xlat16_44 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_44 = min(max(u_xlat16_44, 0.0), 1.0);
#else
    u_xlat16_44 = clamp(u_xlat16_44, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_44);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat16_44 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_44 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_44);
    u_xlat16_4 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_44) + u_xlat16_10.xyz;
    u_xlat4.xyz = vs_TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_11.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_11.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_11.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_10.xyz = u_xlat16_10.xyz + u_xlat16_11.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_12.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = unity_Lightmap_HDR.xxx * u_xlat16_12.xyz + u_xlat16_6.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat16_44 = (-u_xlat14.x) + 1.0;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_8.xyz = vec3(u_xlat16_44) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat1.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat16_0 = (-u_xlat16_13) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_13;
    u_xlat16_13 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_13 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * _Wave2Freq;
    u_xlat5 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat5 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat10 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat15 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<u_xlat15);
#else
    u_xlatb15 = 0.0<u_xlat15;
#endif
    u_xlat5 = u_xlat5 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat5 = _WaveHeight * u_xlat3.x + u_xlat10;
    u_xlat2.x = u_xlat5 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat5 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
mediump float u_xlat16_13;
vec3 u_xlat14;
vec2 u_xlat26;
float u_xlat42;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat13.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat14.xyz = u_xlat13.xyz * u_xlat1.xxx;
    u_xlat13.xyz = u_xlat13.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat14.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat14.xyz);
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
    u_xlat42 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat42;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_44 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_44 = (-u_xlat16_44) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_44);
    u_xlat3.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat13.xyz = u_xlat13.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat13.xyz);
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
    u_xlat13.x = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
    u_xlat26.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat26.x + 1.00001001;
    u_xlat0.x = u_xlat13.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat13.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat13.xy = sin(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat13.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat13.xy;
    u_xlat13.xy = fract(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat13.xy).xyz;
    u_xlat16_13 = texture(_WhitecapsAlpha, u_xlat13.xy).x;
    u_xlat16_13 = (-u_xlat16_13) + 1.0;
    u_xlat26.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat26.xy = fract(u_xlat26.xy);
    u_xlat26.xy = u_xlat26.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat26.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_44 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_44) * u_xlat16_7.xyz;
    u_xlat16_44 = (-u_xlat16_44) + _Smoothness;
    u_xlat16_44 = u_xlat16_44 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_44 = min(max(u_xlat16_44, 0.0), 1.0);
#else
    u_xlat16_44 = clamp(u_xlat16_44, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_44);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat16_44 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_44 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_44);
    u_xlat16_4 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_44) + u_xlat16_10.xyz;
    u_xlat4.xyz = vs_TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_11.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_11.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_11.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_10.xyz = u_xlat16_10.xyz + u_xlat16_11.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_12.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = unity_Lightmap_HDR.xxx * u_xlat16_12.xyz + u_xlat16_6.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat16_44 = (-u_xlat14.x) + 1.0;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_8.xyz = vec3(u_xlat16_44) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat1.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat16_0 = (-u_xlat16_13) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_13;
    u_xlat16_13 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_13 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * _Wave2Freq;
    u_xlat5 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat5 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat10 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat15 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<u_xlat15);
#else
    u_xlatb15 = 0.0<u_xlat15;
#endif
    u_xlat5 = u_xlat5 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat5 = _WaveHeight * u_xlat3.x + u_xlat10;
    u_xlat2.x = u_xlat5 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat5 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump float u_xlat16_16;
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
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = (-u_xlat26) + 1.0;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat2.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat2.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat2.xy;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD0.zw;
    u_xlat16_3.xyz = texture(_Whitecaps, u_xlat2.xy).xyz;
    u_xlat16_16 = texture(_WhitecapsAlpha, u_xlat2.xy).x;
    u_xlat16_16 = (-u_xlat16_16) + 1.0;
    u_xlat2.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_2.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_29 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_5.xyz = vec3(u_xlat16_28) * u_xlat16_5.xyz;
    u_xlat16_28 = u_xlat16_29 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_28);
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_2.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_28 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_28) * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat24) * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0 = (-u_xlat16_16) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_16;
    u_xlat16_8 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_8 * u_xlat16_1.w + u_xlat0.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    SV_Target0.w = u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * _Wave2Freq;
    u_xlat5 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat5 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat10 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat15 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<u_xlat15);
#else
    u_xlatb15 = 0.0<u_xlat15;
#endif
    u_xlat5 = u_xlat5 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat5 = _WaveHeight * u_xlat3.x + u_xlat10;
    u_xlat2.x = u_xlat5 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat5 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec3 u_xlat12;
vec2 u_xlat22;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_38 = (-u_xlat16_38) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
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
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22.x + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat11.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat11.xy;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = texture(_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + 1.0;
    u_xlat22.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_38);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_38 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = vec3(u_xlat16_38) * _LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat16_10.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat12.x) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat1.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat16_0 = (-u_xlat16_11) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_11;
    u_xlat16_11 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_11 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * _Wave2Freq;
    u_xlat5 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat5 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat10 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat15 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<u_xlat15);
#else
    u_xlatb15 = 0.0<u_xlat15;
#endif
    u_xlat5 = u_xlat5 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat5 = _WaveHeight * u_xlat3.x + u_xlat10;
    u_xlat2.x = u_xlat5 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat5 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec3 u_xlat12;
vec2 u_xlat22;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_38 = (-u_xlat16_38) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
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
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22.x + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat11.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat11.xy;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = texture(_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + 1.0;
    u_xlat22.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_38);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_38 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = vec3(u_xlat16_38) * _LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat16_10.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat12.x) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat1.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat16_0 = (-u_xlat16_11) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_11;
    u_xlat16_11 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_11 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * _Wave2Freq;
    u_xlat5 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat5 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat10 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat15 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<u_xlat15);
#else
    u_xlatb15 = 0.0<u_xlat15;
#endif
    u_xlat5 = u_xlat5 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat5 = _WaveHeight * u_xlat3.x + u_xlat10;
    u_xlat2.x = u_xlat5 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat5 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_12;
mediump float u_xlat16_21;
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
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
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
    u_xlat4.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat4.xy = sin(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat4.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat4.xy;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.zw;
    u_xlat16_5.xyz = texture(_Whitecaps, u_xlat4.xy).xyz;
    u_xlat16_21 = texture(_WhitecapsAlpha, u_xlat4.xy).x;
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat4.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat4.xy);
    u_xlat16_4.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_27 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_29 = (-u_xlat16_27) + _Smoothness;
    u_xlat16_6.xyz = vec3(u_xlat16_27) * u_xlat16_6.xyz;
    u_xlat16_27 = u_xlat16_29 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_27);
    u_xlat16_8.xyz = vec3(u_xlat16_12) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat3.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_27 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_27) * _LightColor0.xyz;
    u_xlat16_6.xyz = vec3(u_xlat30) * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat16_3.x = (-u_xlat16_21) + 1.0;
    u_xlat3.x = vs_TEXCOORD3 * u_xlat16_3.x + u_xlat16_21;
    u_xlat16_12 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat3.x = u_xlat16_12 * u_xlat16_1.w + u_xlat3.x;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    SV_Target0.w = u_xlat3.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * _Wave2Freq;
    u_xlat5 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat5 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat10 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat15 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<u_xlat15);
#else
    u_xlatb15 = 0.0<u_xlat15;
#endif
    u_xlat5 = u_xlat5 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat5 = _WaveHeight * u_xlat3.x + u_xlat10;
    u_xlat2.x = u_xlat5 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat5 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
mediump float u_xlat16_13;
vec3 u_xlat14;
vec2 u_xlat26;
float u_xlat42;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat13.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat14.xyz = u_xlat13.xyz * u_xlat1.xxx;
    u_xlat13.xyz = u_xlat13.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat14.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat14.xyz);
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
    u_xlat42 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat42;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_44 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_44 = (-u_xlat16_44) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_44);
    u_xlat3.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat13.xyz = u_xlat13.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat13.xyz);
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
    u_xlat13.x = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
    u_xlat26.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat26.x + 1.00001001;
    u_xlat0.x = u_xlat13.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat13.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat13.xy = sin(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat13.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat13.xy;
    u_xlat13.xy = fract(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat13.xy).xyz;
    u_xlat16_13 = texture(_WhitecapsAlpha, u_xlat13.xy).x;
    u_xlat16_13 = (-u_xlat16_13) + 1.0;
    u_xlat26.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat26.xy = fract(u_xlat26.xy);
    u_xlat26.xy = u_xlat26.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat26.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_44 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_44) * u_xlat16_7.xyz;
    u_xlat16_44 = (-u_xlat16_44) + _Smoothness;
    u_xlat16_44 = u_xlat16_44 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_44 = min(max(u_xlat16_44, 0.0), 1.0);
#else
    u_xlat16_44 = clamp(u_xlat16_44, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_44);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_44 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_44 = min(max(u_xlat16_44, 0.0), 1.0);
#else
    u_xlat16_44 = clamp(u_xlat16_44, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = vec3(u_xlat16_44) * _LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat16_10.xyz;
    u_xlat16_44 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_44 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_44);
    u_xlat16_4 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_44) + u_xlat16_10.xyz;
    u_xlat4.xyz = vs_TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_11.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_11.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_11.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_10.xyz = u_xlat16_10.xyz + u_xlat16_11.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_12.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = unity_Lightmap_HDR.xxx * u_xlat16_12.xyz + u_xlat16_6.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat16_44 = (-u_xlat14.x) + 1.0;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_8.xyz = vec3(u_xlat16_44) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat1.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat16_0 = (-u_xlat16_13) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_13;
    u_xlat16_13 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_13 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec3 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * _Wave2Freq;
    u_xlat5 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat5 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat10 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat15 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<u_xlat15);
#else
    u_xlatb15 = 0.0<u_xlat15;
#endif
    u_xlat5 = u_xlat5 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat5 = _WaveHeight * u_xlat3.x + u_xlat10;
    u_xlat2.x = u_xlat5 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat5 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
mediump float u_xlat16_13;
vec3 u_xlat14;
vec2 u_xlat26;
float u_xlat42;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat13.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat14.xyz = u_xlat13.xyz * u_xlat1.xxx;
    u_xlat13.xyz = u_xlat13.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat14.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat14.xyz);
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
    u_xlat42 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat42;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_44 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_44 = (-u_xlat16_44) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_44);
    u_xlat3.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat13.xyz = u_xlat13.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat13.xyz);
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
    u_xlat13.x = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
    u_xlat26.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat26.x + 1.00001001;
    u_xlat0.x = u_xlat13.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat13.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat13.xy = sin(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat13.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat13.xy;
    u_xlat13.xy = fract(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat13.xy).xyz;
    u_xlat16_13 = texture(_WhitecapsAlpha, u_xlat13.xy).x;
    u_xlat16_13 = (-u_xlat16_13) + 1.0;
    u_xlat26.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat26.xy = fract(u_xlat26.xy);
    u_xlat26.xy = u_xlat26.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat26.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_44 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_44) * u_xlat16_7.xyz;
    u_xlat16_44 = (-u_xlat16_44) + _Smoothness;
    u_xlat16_44 = u_xlat16_44 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_44 = min(max(u_xlat16_44, 0.0), 1.0);
#else
    u_xlat16_44 = clamp(u_xlat16_44, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_44);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_44 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_44 = min(max(u_xlat16_44, 0.0), 1.0);
#else
    u_xlat16_44 = clamp(u_xlat16_44, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = vec3(u_xlat16_44) * _LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat16_10.xyz;
    u_xlat16_44 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_44 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_44);
    u_xlat16_4 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_44) + u_xlat16_10.xyz;
    u_xlat4.xyz = vs_TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_11.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_11.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_11.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_10.xyz = u_xlat16_10.xyz + u_xlat16_11.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_12.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = unity_Lightmap_HDR.xxx * u_xlat16_12.xyz + u_xlat16_6.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat16_44 = (-u_xlat14.x) + 1.0;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_8.xyz = vec3(u_xlat16_44) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat1.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat16_0 = (-u_xlat16_13) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_13;
    u_xlat16_13 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_13 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD6;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    vs_TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat16_6 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_6);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
vec2 u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat18.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat18.xy = sin(u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat18.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat18.xy;
    u_xlat18.xy = fract(u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy + vs_TEXCOORD0.zw;
    u_xlat16_2.xyz = texture(_Whitecaps, u_xlat18.xy).xyz;
    u_xlat16_18 = texture(_WhitecapsAlpha, u_xlat18.xy).x;
    u_xlat16_18 = (-u_xlat16_18) + 1.0;
    u_xlat3.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_3.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_31 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_31) + _Smoothness;
    u_xlat16_32 = u_xlat16_32 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_32);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz;
    u_xlat16_4.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyw = u_xlat16_4.xyz + (-unity_FogColor.xyz);
    u_xlat2.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_0.xyw + unity_FogColor.xyz;
    u_xlat16_0.x = (-u_xlat16_18) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0.x + u_xlat16_18;
    u_xlat16_9 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_9 * u_xlat16_1.w + u_xlat0.x;
    u_xlat2.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat2;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD6;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    vs_TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat16_6 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_6);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
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
vec3 u_xlat11;
mediump float u_xlat16_11;
float u_xlat20;
vec2 u_xlat21;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * vec3(u_xlat1);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1<9.99999975e-06;
#endif
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
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
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat11.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat11.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat11.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat11.xy;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = texture(_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + 1.0;
    u_xlat21.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat21.xy = fract(u_xlat21.xy);
    u_xlat21.xy = u_xlat21.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat21.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_37 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_38 = (-u_xlat16_37) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_38);
    u_xlat16_9.xyz = vec3(u_xlat16_35) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat21.x = max(u_xlat21.x, 0.00100000005);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat21.xxx;
    u_xlat21.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21.x = min(max(u_xlat21.x, 0.0), 1.0);
#else
    u_xlat21.x = clamp(u_xlat21.x, 0.0, 1.0);
#endif
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat20 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat30 = max(u_xlat21.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat30;
    u_xlat30 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat30 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = u_xlat16_8.xyz * u_xlat0.xxx;
    u_xlat0.xyw = u_xlat16_7.xyz * vec3(u_xlat16_37) + u_xlat0.xyw;
    u_xlat0.xyw = u_xlat0.xyw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * vec3(u_xlat20) + u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat16_1 = (-u_xlat16_11) + 1.0;
    u_xlat1 = vs_TEXCOORD3 * u_xlat16_1 + u_xlat16_11;
    u_xlat16_11 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat1 = u_xlat16_11 * u_xlat16_2.w + u_xlat1;
    u_xlat0.w = min(u_xlat1, 1.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD6;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    vs_TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat16_6 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_6);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
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
vec3 u_xlat11;
mediump float u_xlat16_11;
float u_xlat20;
vec2 u_xlat21;
float u_xlat30;
float u_xlat33;
mediump float u_xlat16_35;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat11.xyz = u_xlat10.xyz * vec3(u_xlat1);
    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat11.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat11.xyz);
    u_xlat1 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1<9.99999975e-06;
#endif
    u_xlat1 = (u_xlatb1) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat1 * u_xlat16_2.x;
    u_xlat4.x = u_xlat1 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat1 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat3.xyz = vec3(u_xlat1) * u_xlat3.xyz;
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
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_35 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_35 = (-u_xlat16_35) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_35);
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat11.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat11.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat11.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat11.xy;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = texture(_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + 1.0;
    u_xlat21.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat21.xy = fract(u_xlat21.xy);
    u_xlat21.xy = u_xlat21.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat21.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_37 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_38 = (-u_xlat16_37) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_38);
    u_xlat16_9.xyz = vec3(u_xlat16_35) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat21.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat21.x = max(u_xlat21.x, 0.00100000005);
    u_xlat21.x = inversesqrt(u_xlat21.x);
    u_xlat10.xyz = u_xlat10.xyz * u_xlat21.xxx;
    u_xlat21.x = dot(_WorldSpaceLightPos0.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21.x = min(max(u_xlat21.x, 0.0), 1.0);
#else
    u_xlat21.x = clamp(u_xlat21.x, 0.0, 1.0);
#endif
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat20 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat10.x = u_xlat10.x * u_xlat10.x;
    u_xlat30 = max(u_xlat21.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat30;
    u_xlat30 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat30 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = u_xlat16_8.xyz * u_xlat0.xxx;
    u_xlat0.xyw = u_xlat16_7.xyz * vec3(u_xlat16_37) + u_xlat0.xyw;
    u_xlat0.xyw = u_xlat0.xyw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * vec3(u_xlat20) + u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    u_xlat16_1 = (-u_xlat16_11) + 1.0;
    u_xlat1 = vs_TEXCOORD3 * u_xlat16_1 + u_xlat16_11;
    u_xlat16_11 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat1 = u_xlat16_11 * u_xlat16_2.w + u_xlat1;
    u_xlat0.w = min(u_xlat1, 1.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_5);
    vs_COLOR0 = in_COLOR0;
    u_xlat16_5 = u_xlat7.y * u_xlat7.y;
    u_xlat16_5 = u_xlat7.x * u_xlat7.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat7.yzzx * u_xlat7.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
vec2 u_xlat20;
mediump float u_xlat16_20;
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
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD4.xyz;
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
    u_xlat20.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat20.xy = sin(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat20.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat20.xy;
    u_xlat20.xy = fract(u_xlat20.xy);
    u_xlat20.xy = u_xlat20.xy + vs_TEXCOORD0.zw;
    u_xlat16_3.xyz = texture(_Whitecaps, u_xlat20.xy).xyz;
    u_xlat16_20 = texture(_WhitecapsAlpha, u_xlat20.xy).x;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat4.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat4.xy);
    u_xlat16_4.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_31 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_35 = (-u_xlat16_31) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat16_31 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_31);
    u_xlat16_9.xyz = vec3(u_xlat16_10) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_6.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyw = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat3.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat3.xxx * u_xlat16_0.xyw + unity_FogColor.xyz;
    u_xlat16_0.x = (-u_xlat16_20) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0.x + u_xlat16_20;
    u_xlat16_10 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_10 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_5);
    vs_COLOR0 = in_COLOR0;
    u_xlat16_5 = u_xlat7.y * u_xlat7.y;
    u_xlat16_5 = u_xlat7.x * u_xlat7.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat7.yzzx * u_xlat7.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec3 u_xlat12;
vec2 u_xlat22;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_38 = (-u_xlat16_38) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
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
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22.x + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat11.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat11.xy;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = texture(_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + 1.0;
    u_xlat22.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_38);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat4.xyz = vs_TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_10.xyz = u_xlat16_10.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat12.x) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw + (-unity_FogColor.xyz);
    u_xlat1.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xxx * u_xlat0.xzw + unity_FogColor.xyz;
    u_xlat16_0 = (-u_xlat16_11) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_11;
    u_xlat16_11 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_11 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_5);
    vs_COLOR0 = in_COLOR0;
    u_xlat16_5 = u_xlat7.y * u_xlat7.y;
    u_xlat16_5 = u_xlat7.x * u_xlat7.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat7.yzzx * u_xlat7.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec3 u_xlat12;
vec2 u_xlat22;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_38 = (-u_xlat16_38) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
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
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22.x + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat11.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat11.xy;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = texture(_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + 1.0;
    u_xlat22.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_38);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat4.xyz = vs_TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_10.xyz = u_xlat16_10.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat12.x) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw + (-unity_FogColor.xyz);
    u_xlat1.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xxx * u_xlat0.xzw + unity_FogColor.xyz;
    u_xlat16_0 = (-u_xlat16_11) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_11;
    u_xlat16_11 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_11 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_5);
    vs_COLOR0 = in_COLOR0;
    u_xlat16_5 = u_xlat7.y * u_xlat7.y;
    u_xlat16_5 = u_xlat7.x * u_xlat7.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat7.yzzx * u_xlat7.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
mediump float u_xlat16_18;
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
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD4.xyz;
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
    u_xlat3.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat3.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat3.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat3.xy;
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat3.xy).xyz;
    u_xlat16_18 = texture(_WhitecapsAlpha, u_xlat3.xy).x;
    u_xlat16_18 = (-u_xlat16_18) + 1.0;
    u_xlat3.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_3.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_6.xyz = vec3(u_xlat16_28) * u_xlat16_6.xyz;
    u_xlat16_28 = u_xlat16_32 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_28);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_3 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_28 = dot(u_xlat16_3, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_28) * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyw = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat3.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat3.xxx * u_xlat16_0.xyw + unity_FogColor.xyz;
    u_xlat16_0.x = (-u_xlat16_18) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0.x + u_xlat16_18;
    u_xlat16_9 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_9 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_5);
    vs_COLOR0 = in_COLOR0;
    u_xlat16_5 = u_xlat7.y * u_xlat7.y;
    u_xlat16_5 = u_xlat7.x * u_xlat7.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat7.yzzx * u_xlat7.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec3 u_xlat12;
vec2 u_xlat22;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_38 = (-u_xlat16_38) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
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
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22.x + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat11.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat11.xy;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = texture(_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + 1.0;
    u_xlat22.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_38);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_38 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = vec3(u_xlat16_38) * _LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat16_10.xyz;
    u_xlat4.xyz = vs_TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_10.xyz = u_xlat16_10.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat12.x) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw + (-unity_FogColor.xyz);
    u_xlat1.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xxx * u_xlat0.xzw + unity_FogColor.xyz;
    u_xlat16_0 = (-u_xlat16_11) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_11;
    u_xlat16_11 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_11 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat4.x = (-u_xlat1.x);
    u_xlat4.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_5 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_5);
    vs_COLOR0 = in_COLOR0;
    u_xlat16_5 = u_xlat7.y * u_xlat7.y;
    u_xlat16_5 = u_xlat7.x * u_xlat7.x + (-u_xlat16_5);
    u_xlat16_0 = u_xlat7.yzzx * u_xlat7.xyzz;
    u_xlat16_6.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_6.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_6.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_5) + u_xlat16_6.xyz;
    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec3 u_xlat12;
vec2 u_xlat22;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_38 = (-u_xlat16_38) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
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
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22.x + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat11.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat11.xy;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = texture(_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + 1.0;
    u_xlat22.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_38);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_38 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = vec3(u_xlat16_38) * _LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat16_10.xyz;
    u_xlat4.xyz = vs_TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_10.xyz = u_xlat16_10.xyz + vs_TEXCOORD4.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat12.x) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw + (-unity_FogColor.xyz);
    u_xlat1.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xxx * u_xlat0.xzw + unity_FogColor.xyz;
    u_xlat16_0 = (-u_xlat16_11) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_11;
    u_xlat16_11 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_11 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    vs_TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat16_6 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_6);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
vec2 u_xlat18;
mediump float u_xlat16_18;
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
    u_xlat18.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat18.xy = sin(u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat18.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat18.xy;
    u_xlat18.xy = fract(u_xlat18.xy);
    u_xlat18.xy = u_xlat18.xy + vs_TEXCOORD0.zw;
    u_xlat16_2.xyz = texture(_Whitecaps, u_xlat18.xy).xyz;
    u_xlat16_18 = texture(_WhitecapsAlpha, u_xlat18.xy).x;
    u_xlat16_18 = (-u_xlat16_18) + 1.0;
    u_xlat3.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_3.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_31 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_31) + _Smoothness;
    u_xlat16_6.xyz = vec3(u_xlat16_31) * u_xlat16_6.xyz;
    u_xlat16_31 = u_xlat16_32 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_31);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyw = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyw * unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_8.xyz * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyw = u_xlat16_4.xyz + (-unity_FogColor.xyz);
    u_xlat2.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_0.xyw + unity_FogColor.xyz;
    u_xlat16_0.x = (-u_xlat16_18) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0.x + u_xlat16_18;
    u_xlat16_9 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_9 * u_xlat16_1.w + u_xlat0.x;
    u_xlat2.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat2;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    vs_TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat16_6 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_6);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
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
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec3 u_xlat12;
vec2 u_xlat22;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_38 = (-u_xlat16_38) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
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
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22.x + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat11.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat11.xy;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = texture(_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + 1.0;
    u_xlat22.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_38);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat12.x) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw + (-unity_FogColor.xyz);
    u_xlat1.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xxx * u_xlat0.xzw + unity_FogColor.xyz;
    u_xlat16_0 = (-u_xlat16_11) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_11;
    u_xlat16_11 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_11 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    vs_TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat16_6 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_6);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
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
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec3 u_xlat12;
vec2 u_xlat22;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_38 = (-u_xlat16_38) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
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
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22.x + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat11.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat11.xy;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = texture(_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + 1.0;
    u_xlat22.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_38);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat12.x) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw + (-unity_FogColor.xyz);
    u_xlat1.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xxx * u_xlat0.xzw + unity_FogColor.xyz;
    u_xlat16_0 = (-u_xlat16_11) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_11;
    u_xlat16_11 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_11 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    vs_TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat16_6 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_6);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_13;
vec2 u_xlat23;
mediump float u_xlat16_23;
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
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
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
    u_xlat23.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat23.xy = sin(u_xlat23.xy);
    u_xlat23.xy = u_xlat23.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat23.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat23.xy;
    u_xlat23.xy = fract(u_xlat23.xy);
    u_xlat23.xy = u_xlat23.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat23.xy).xyz;
    u_xlat16_23 = texture(_WhitecapsAlpha, u_xlat23.xy).x;
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat5.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat5.xy = fract(u_xlat5.xy);
    u_xlat5.xy = u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat5.xy);
    u_xlat16_5.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_1.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_30 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_30) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_30) * u_xlat16_7.xyz;
    u_xlat16_30 = u_xlat16_32 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_30);
    u_xlat16_9.xyz = vec3(u_xlat16_13) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat3.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_9.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_8.xyz * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyw = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat4.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat4.xxx * u_xlat16_3.xyw + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat16_23) + 1.0;
    u_xlat3.x = vs_TEXCOORD3 * u_xlat16_3.x + u_xlat16_23;
    u_xlat16_13 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat3.x = u_xlat16_13 * u_xlat16_1.w + u_xlat3.x;
    u_xlat0.w = min(u_xlat3.x, 1.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    vs_TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat16_6 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_6);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
mediump float u_xlat16_13;
vec3 u_xlat14;
vec2 u_xlat26;
float u_xlat42;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat13.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat14.xyz = u_xlat13.xyz * u_xlat1.xxx;
    u_xlat13.xyz = u_xlat13.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat14.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat14.xyz);
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
    u_xlat42 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat42;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_44 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_44 = (-u_xlat16_44) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_44);
    u_xlat3.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat13.xyz = u_xlat13.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat13.xyz);
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
    u_xlat13.x = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
    u_xlat26.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat26.x + 1.00001001;
    u_xlat0.x = u_xlat13.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat13.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat13.xy = sin(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat13.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat13.xy;
    u_xlat13.xy = fract(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat13.xy).xyz;
    u_xlat16_13 = texture(_WhitecapsAlpha, u_xlat13.xy).x;
    u_xlat16_13 = (-u_xlat16_13) + 1.0;
    u_xlat26.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat26.xy = fract(u_xlat26.xy);
    u_xlat26.xy = u_xlat26.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat26.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_44 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_44) * u_xlat16_7.xyz;
    u_xlat16_44 = (-u_xlat16_44) + _Smoothness;
    u_xlat16_44 = u_xlat16_44 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_44 = min(max(u_xlat16_44, 0.0), 1.0);
#else
    u_xlat16_44 = clamp(u_xlat16_44, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_44);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat16_44 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_44 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_44);
    u_xlat16_4 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_44) + u_xlat16_10.xyz;
    u_xlat4.xyz = vs_TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_11.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_11.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_11.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_10.xyz = u_xlat16_10.xyz + u_xlat16_11.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_12.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = unity_Lightmap_HDR.xxx * u_xlat16_12.xyz + u_xlat16_6.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat16_44 = (-u_xlat14.x) + 1.0;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_8.xyz = vec3(u_xlat16_44) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw + (-unity_FogColor.xyz);
    u_xlat1.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xxx * u_xlat0.xzw + unity_FogColor.xyz;
    u_xlat16_0 = (-u_xlat16_13) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_13;
    u_xlat16_13 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_13 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    vs_TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat16_6 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_6);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
mediump float u_xlat16_13;
vec3 u_xlat14;
vec2 u_xlat26;
float u_xlat42;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat13.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat14.xyz = u_xlat13.xyz * u_xlat1.xxx;
    u_xlat13.xyz = u_xlat13.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat14.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat14.xyz);
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
    u_xlat42 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat42;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_44 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_44 = (-u_xlat16_44) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_44);
    u_xlat3.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat13.xyz = u_xlat13.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat13.xyz);
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
    u_xlat13.x = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
    u_xlat26.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat26.x + 1.00001001;
    u_xlat0.x = u_xlat13.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat13.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat13.xy = sin(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat13.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat13.xy;
    u_xlat13.xy = fract(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat13.xy).xyz;
    u_xlat16_13 = texture(_WhitecapsAlpha, u_xlat13.xy).x;
    u_xlat16_13 = (-u_xlat16_13) + 1.0;
    u_xlat26.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat26.xy = fract(u_xlat26.xy);
    u_xlat26.xy = u_xlat26.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat26.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_44 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_44) * u_xlat16_7.xyz;
    u_xlat16_44 = (-u_xlat16_44) + _Smoothness;
    u_xlat16_44 = u_xlat16_44 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_44 = min(max(u_xlat16_44, 0.0), 1.0);
#else
    u_xlat16_44 = clamp(u_xlat16_44, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_44);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat16_44 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_44 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_44);
    u_xlat16_4 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_44) + u_xlat16_10.xyz;
    u_xlat4.xyz = vs_TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_11.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_11.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_11.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_10.xyz = u_xlat16_10.xyz + u_xlat16_11.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_12.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = unity_Lightmap_HDR.xxx * u_xlat16_12.xyz + u_xlat16_6.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat16_44 = (-u_xlat14.x) + 1.0;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_8.xyz = vec3(u_xlat16_44) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw + (-unity_FogColor.xyz);
    u_xlat1.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xxx * u_xlat0.xzw + unity_FogColor.xyz;
    u_xlat16_0 = (-u_xlat16_13) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_13;
    u_xlat16_13 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_13 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    vs_TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat16_6 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_6);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump float u_xlat16_16;
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
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat3.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_28 = (-u_xlat26) + 1.0;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat16_8 = u_xlat16_28 * u_xlat16_8;
    u_xlat2.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat2.xy = sin(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat2.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat2.xy;
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD0.zw;
    u_xlat16_3.xyz = texture(_Whitecaps, u_xlat2.xy).xyz;
    u_xlat16_16 = texture(_WhitecapsAlpha, u_xlat2.xy).x;
    u_xlat16_16 = (-u_xlat16_16) + 1.0;
    u_xlat2.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat2.xy);
    u_xlat16_2.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_29 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_5.xyz = vec3(u_xlat16_28) * u_xlat16_5.xyz;
    u_xlat16_28 = u_xlat16_29 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_28);
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_2.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_28 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_28) * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat24) * u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyw = u_xlat16_4.xyz + (-unity_FogColor.xyz);
    u_xlat2.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_0.xyw + unity_FogColor.xyz;
    u_xlat16_0.x = (-u_xlat16_16) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0.x + u_xlat16_16;
    u_xlat16_8 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_8 * u_xlat16_1.w + u_xlat0.x;
    u_xlat2.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat2;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    vs_TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat16_6 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_6);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec3 u_xlat12;
vec2 u_xlat22;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_38 = (-u_xlat16_38) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
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
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22.x + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat11.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat11.xy;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = texture(_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + 1.0;
    u_xlat22.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_38);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_38 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = vec3(u_xlat16_38) * _LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat16_10.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat12.x) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw + (-unity_FogColor.xyz);
    u_xlat1.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xxx * u_xlat0.xzw + unity_FogColor.xyz;
    u_xlat16_0 = (-u_xlat16_11) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_11;
    u_xlat16_11 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_11 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    vs_TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat16_6 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_6);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
vec3 u_xlat11;
mediump float u_xlat16_11;
vec3 u_xlat12;
vec2 u_xlat22;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat12.xyz = u_xlat11.xyz * u_xlat1.xxx;
    u_xlat11.xyz = u_xlat11.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_38 = (-u_xlat16_38) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_38);
    u_xlat3.x = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat11.xyz = u_xlat11.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat11.xyz);
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
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat11.x = u_xlat11.x * u_xlat11.x;
    u_xlat22.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22.x + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat11.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat11.xy = sin(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat11.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat11.xy;
    u_xlat11.xy = fract(u_xlat11.xy);
    u_xlat11.xy = u_xlat11.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat11.xy).xyz;
    u_xlat16_11 = texture(_WhitecapsAlpha, u_xlat11.xy).x;
    u_xlat16_11 = (-u_xlat16_11) + 1.0;
    u_xlat22.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat22.xy = fract(u_xlat22.xy);
    u_xlat22.xy = u_xlat22.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat22.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_38);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_38 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = vec3(u_xlat16_38) * _LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat16_10.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat12.x = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat12.x) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw + (-unity_FogColor.xyz);
    u_xlat1.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xxx * u_xlat0.xzw + unity_FogColor.xyz;
    u_xlat16_0 = (-u_xlat16_11) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_11;
    u_xlat16_11 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_11 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    vs_TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat16_6 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_6);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_12;
mediump float u_xlat16_21;
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
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
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
    u_xlat4.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat4.xy = sin(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat4.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat4.xy;
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.zw;
    u_xlat16_5.xyz = texture(_Whitecaps, u_xlat4.xy).xyz;
    u_xlat16_21 = texture(_WhitecapsAlpha, u_xlat4.xy).x;
    u_xlat16_21 = (-u_xlat16_21) + 1.0;
    u_xlat4.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat4.xy = fract(u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat4.xy);
    u_xlat16_4.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_27 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_29 = (-u_xlat16_27) + _Smoothness;
    u_xlat16_6.xyz = vec3(u_xlat16_27) * u_xlat16_6.xyz;
    u_xlat16_27 = u_xlat16_29 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_27);
    u_xlat16_8.xyz = vec3(u_xlat16_12) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat3.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_27 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_27) * _LightColor0.xyz;
    u_xlat16_6.xyz = vec3(u_xlat30) * u_xlat16_6.xyz;
    u_xlat16_0.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyw = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat4.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat4.xxx * u_xlat16_3.xyw + unity_FogColor.xyz;
    u_xlat16_3.x = (-u_xlat16_21) + 1.0;
    u_xlat3.x = vs_TEXCOORD3 * u_xlat16_3.x + u_xlat16_21;
    u_xlat16_12 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat3.x = u_xlat16_12 * u_xlat16_1.w + u_xlat3.x;
    u_xlat0.w = min(u_xlat3.x, 1.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    vs_TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat16_6 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_6);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
mediump float u_xlat16_13;
vec3 u_xlat14;
vec2 u_xlat26;
float u_xlat42;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat13.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat14.xyz = u_xlat13.xyz * u_xlat1.xxx;
    u_xlat13.xyz = u_xlat13.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat14.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat14.xyz);
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
    u_xlat42 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat42;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_44 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_44 = (-u_xlat16_44) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_44);
    u_xlat3.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat13.xyz = u_xlat13.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat13.xyz);
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
    u_xlat13.x = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
    u_xlat26.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat26.x + 1.00001001;
    u_xlat0.x = u_xlat13.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat13.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat13.xy = sin(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat13.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat13.xy;
    u_xlat13.xy = fract(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat13.xy).xyz;
    u_xlat16_13 = texture(_WhitecapsAlpha, u_xlat13.xy).x;
    u_xlat16_13 = (-u_xlat16_13) + 1.0;
    u_xlat26.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat26.xy = fract(u_xlat26.xy);
    u_xlat26.xy = u_xlat26.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat26.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_44 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_44) * u_xlat16_7.xyz;
    u_xlat16_44 = (-u_xlat16_44) + _Smoothness;
    u_xlat16_44 = u_xlat16_44 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_44 = min(max(u_xlat16_44, 0.0), 1.0);
#else
    u_xlat16_44 = clamp(u_xlat16_44, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_44);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_44 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_44 = min(max(u_xlat16_44, 0.0), 1.0);
#else
    u_xlat16_44 = clamp(u_xlat16_44, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = vec3(u_xlat16_44) * _LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat16_10.xyz;
    u_xlat16_44 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_44 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_44);
    u_xlat16_4 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_44) + u_xlat16_10.xyz;
    u_xlat4.xyz = vs_TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_11.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_11.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_11.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_10.xyz = u_xlat16_10.xyz + u_xlat16_11.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_12.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = unity_Lightmap_HDR.xxx * u_xlat16_12.xyz + u_xlat16_6.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat16_44 = (-u_xlat14.x) + 1.0;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_8.xyz = vec3(u_xlat16_44) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw + (-unity_FogColor.xyz);
    u_xlat1.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xxx * u_xlat0.xzw + unity_FogColor.xyz;
    u_xlat16_0 = (-u_xlat16_13) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_13;
    u_xlat16_13 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_13 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    vs_TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat16_6 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_6);
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD6.xy = u_xlat0.xy;
    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsBaseAlpha;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform mediump sampler2D _WhitecapsAlpha;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
mediump float u_xlat16_13;
vec3 u_xlat14;
vec2 u_xlat26;
float u_xlat42;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat13.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat14.xyz = u_xlat13.xyz * u_xlat1.xxx;
    u_xlat13.xyz = u_xlat13.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat14.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat14.xyz);
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
    u_xlat42 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat42;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_44 = u_xlat0.x * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_44 = (-u_xlat16_44) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_44);
    u_xlat3.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat13.xyz = u_xlat13.xyz * u_xlat3.xxx;
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat13.xyz);
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
    u_xlat13.x = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat13.x = min(max(u_xlat13.x, 0.0), 1.0);
#else
    u_xlat13.x = clamp(u_xlat13.x, 0.0, 1.0);
#endif
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
    u_xlat26.x = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat13.x = u_xlat13.x * u_xlat26.x + 1.00001001;
    u_xlat0.x = u_xlat13.x * u_xlat0.x;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat13.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat13.xy = sin(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat13.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat13.xy;
    u_xlat13.xy = fract(u_xlat13.xy);
    u_xlat13.xy = u_xlat13.xy + vs_TEXCOORD0.zw;
    u_xlat16_4.xyz = texture(_Whitecaps, u_xlat13.xy).xyz;
    u_xlat16_13 = texture(_WhitecapsAlpha, u_xlat13.xy).x;
    u_xlat16_13 = (-u_xlat16_13) + 1.0;
    u_xlat26.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat26.xy = fract(u_xlat26.xy);
    u_xlat26.xy = u_xlat26.xy + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat26.xy);
    u_xlat16_6.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_44 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_44) * u_xlat16_7.xyz;
    u_xlat16_44 = (-u_xlat16_44) + _Smoothness;
    u_xlat16_44 = u_xlat16_44 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_44 = min(max(u_xlat16_44, 0.0), 1.0);
#else
    u_xlat16_44 = clamp(u_xlat16_44, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_44);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_44 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_44 = min(max(u_xlat16_44, 0.0), 1.0);
#else
    u_xlat16_44 = clamp(u_xlat16_44, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = vec3(u_xlat16_44) * _LightColor0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat16_10.xyz;
    u_xlat16_44 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_44 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_44);
    u_xlat16_4 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_10.x = dot(unity_SHBr, u_xlat16_4);
    u_xlat16_10.y = dot(unity_SHBg, u_xlat16_4);
    u_xlat16_10.z = dot(unity_SHBb, u_xlat16_4);
    u_xlat16_10.xyz = unity_SHC.xyz * vec3(u_xlat16_44) + u_xlat16_10.xyz;
    u_xlat4.xyz = vs_TEXCOORD1.xyz;
    u_xlat4.w = 1.0;
    u_xlat16_11.x = dot(unity_SHAr, u_xlat4);
    u_xlat16_11.y = dot(unity_SHAg, u_xlat4);
    u_xlat16_11.z = dot(unity_SHAb, u_xlat4);
    u_xlat16_10.xyz = u_xlat16_10.xyz + u_xlat16_11.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = log2(u_xlat16_10.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_12.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_10.xyz = unity_Lightmap_HDR.xxx * u_xlat16_12.xyz + u_xlat16_6.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_10.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat14.x = dot(u_xlat3.xyz, u_xlat14.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat14.x = min(max(u_xlat14.x, 0.0), 1.0);
#else
    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
#endif
    u_xlat16_44 = (-u_xlat14.x) + 1.0;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_44 = u_xlat16_44 * u_xlat16_44;
    u_xlat16_8.xyz = vec3(u_xlat16_44) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xxx + u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw + (-unity_FogColor.xyz);
    u_xlat1.x = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat1.xxx * u_xlat0.xzw + unity_FogColor.xyz;
    u_xlat16_0 = (-u_xlat16_13) + 1.0;
    u_xlat0.x = vs_TEXCOORD3 * u_xlat16_0 + u_xlat16_13;
    u_xlat16_13 = vs_COLOR0.w + _WhitecapsBaseAlpha;
    u_xlat0.x = u_xlat16_13 * u_xlat16_2.w + u_xlat0.x;
    u_xlat1.w = min(u_xlat0.x, 1.0);
    SV_Target0 = u_xlat1;
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
  GpuProgramID 103205
Program "vp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
vec3 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * _Wave2Freq;
    u_xlat5 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat5 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat10 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat15 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<u_xlat15);
#else
    u_xlatb15 = 0.0<u_xlat15;
#endif
    u_xlat5 = u_xlat5 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat5 = _WaveHeight * u_xlat3.x + u_xlat10;
    u_xlat2.x = u_xlat5 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat5 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform highp sampler2D unity_NHxRoughness;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
mediump vec3 u_xlat16_6;
float u_xlat18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD1.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat0.xyz = u_xlat1.xyz * (-vec3(u_xlat18)) + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat18) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = (-_Smoothness) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat6.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat6.xy = sin(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat6.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat6.xy;
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD0.zw;
    u_xlat16_6.xyz = texture(_Whitecaps, u_xlat6.xy).xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_3.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_5.xyz;
    u_xlat16_20 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_20) + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
vec3 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * _Wave2Freq;
    u_xlat5 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat5 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat10 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat15 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<u_xlat15);
#else
    u_xlatb15 = 0.0<u_xlat15;
#endif
    u_xlat5 = u_xlat5 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat5 = _WaveHeight * u_xlat3.x + u_xlat10;
    u_xlat2.x = u_xlat5 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat5 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_7;
vec2 u_xlat12;
mediump float u_xlat16_12;
float u_xlat18;
mediump float u_xlat16_22;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = max(u_xlat18, 0.319999993);
    u_xlat16_1.x = (-_Smoothness) + 1.0;
    u_xlat16_7 = u_xlat16_1.x * u_xlat16_1.x + 1.5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = u_xlat18 * u_xlat16_7;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat7.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_12 = u_xlat16_1.x * u_xlat16_1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_12 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = u_xlat16_1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat12.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat12.xy = sin(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat12.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat12.xy;
    u_xlat12.xy = fract(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy + vs_TEXCOORD0.zw;
    u_xlat16_1.xyz = texture(_Whitecaps, u_xlat12.xy).xyz;
    u_xlat12.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat12.xy = fract(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy + vs_TEXCOORD0.xy;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat12.xy).xyz;
    u_xlat16_3.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_5.xyz;
    u_xlat16_22 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat16_4.xyz * vec3(u_xlat16_22) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xzw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
vec3 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat10;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat10 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat15 = sqrt(u_xlat10);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.x = u_xlat15 * _Wave2Freq;
    u_xlat5 = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat5 * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat10 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat15 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<u_xlat15);
#else
    u_xlatb15 = 0.0<u_xlat15;
#endif
    u_xlat5 = u_xlat5 * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat5);
    u_xlat3.x = cos(u_xlat5);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat5 = _WaveHeight * u_xlat3.x + u_xlat10;
    u_xlat2.x = u_xlat5 * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat0.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.xx * u_xlat2.xy;
    u_xlat0.z = (-u_xlat0.x);
    u_xlat2.y = dot(u_xlat0.yz, in_NORMAL0.yz);
    u_xlat3 = u_xlat0.xyxy * u_xlat1.xxyy;
    u_xlat0.x = (-u_xlat1.x);
    u_xlat0.yz = u_xlat3.zw;
    u_xlat1.zw = u_xlat3.xy;
    u_xlat2.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat2.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    vs_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat0.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat0.x;
    u_xlat0.x = abs(u_xlat0.x) + (-_WhitecapsDepthMin);
    u_xlat5 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat0.x / u_xlat5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_7;
vec2 u_xlat12;
mediump float u_xlat16_12;
float u_xlat18;
mediump float u_xlat16_22;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = max(u_xlat18, 0.319999993);
    u_xlat16_1.x = (-_Smoothness) + 1.0;
    u_xlat16_7 = u_xlat16_1.x * u_xlat16_1.x + 1.5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = u_xlat18 * u_xlat16_7;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat7.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_12 = u_xlat16_1.x * u_xlat16_1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_12 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = u_xlat16_1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat12.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat12.xy = sin(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat12.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat12.xy;
    u_xlat12.xy = fract(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy + vs_TEXCOORD0.zw;
    u_xlat16_1.xyz = texture(_Whitecaps, u_xlat12.xy).xyz;
    u_xlat12.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat12.xy = fract(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy + vs_TEXCOORD0.xy;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat12.xy).xyz;
    u_xlat16_3.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_5.xyz;
    u_xlat16_22 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat16_4.xyz * vec3(u_xlat16_22) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xzw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD6;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    vs_TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat16_6 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat0.x, u_xlat16_6);
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
uniform highp sampler2D unity_NHxRoughness;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD6;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec2 u_xlat6;
mediump vec3 u_xlat16_6;
float u_xlat18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD1.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat18 = u_xlat18 + u_xlat18;
    u_xlat0.xyz = u_xlat1.xyz * (-vec3(u_xlat18)) + u_xlat0.xyz;
    u_xlat18 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat18) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.y = (-_Smoothness) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat6.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat6.xy = sin(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat6.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat6.xy;
    u_xlat6.xy = fract(u_xlat6.xy);
    u_xlat6.xy = u_xlat6.xy + vs_TEXCOORD0.zw;
    u_xlat16_6.xyz = texture(_Whitecaps, u_xlat6.xy).xyz;
    u_xlat1.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy + vs_TEXCOORD0.xy;
    u_xlat16_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_3.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_5.xyz;
    u_xlat16_20 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_20) + u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    u_xlat0.x = vs_TEXCOORD6;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD6;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    vs_TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat16_6 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat0.x, u_xlat16_6);
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD6;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_7;
vec2 u_xlat12;
mediump float u_xlat16_12;
float u_xlat18;
mediump float u_xlat16_22;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = max(u_xlat18, 0.319999993);
    u_xlat16_1.x = (-_Smoothness) + 1.0;
    u_xlat16_7 = u_xlat16_1.x * u_xlat16_1.x + 1.5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = u_xlat18 * u_xlat16_7;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat7.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_12 = u_xlat16_1.x * u_xlat16_1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_12 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = u_xlat16_1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat12.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat12.xy = sin(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat12.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat12.xy;
    u_xlat12.xy = fract(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy + vs_TEXCOORD0.zw;
    u_xlat16_1.xyz = texture(_Whitecaps, u_xlat12.xy).xyz;
    u_xlat12.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat12.xy = fract(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy + vs_TEXCOORD0.xy;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat12.xy).xyz;
    u_xlat16_3.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_5.xyz;
    u_xlat16_22 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat16_4.xyz * vec3(u_xlat16_22) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xzw;
    u_xlat18 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 booster_Env;
uniform 	float _WhitecapsDepthMin;
uniform 	float _WhitecapsDepthMax;
uniform 	mediump float _WaveFreq;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _WaveHeight;
uniform 	mediump float _Wave2Freq;
uniform 	mediump float _Wave2Speed;
uniform 	mediump float _Wave2Height;
uniform 	mediump float _WaveSlopeMag;
uniform 	mediump vec3 _WaveCenterPos;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Whitecaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD6;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
vec2 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
float u_xlat21;
bool u_xlatb21;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + (-vec2(_WaveCenterPos.x, _WaveCenterPos.z));
    u_xlat14 = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat21 = sqrt(u_xlat14);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat1.xy = vec2(u_xlat14) * u_xlat0.xy;
    u_xlat0.x = u_xlat21 * _Wave2Freq;
    u_xlat7.x = booster_Env.x * 0.0500000007;
    u_xlat0.x = u_xlat7.x * _Wave2Speed + (-u_xlat0.x);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Wave2Height;
    u_xlat14 = u_xlat2.x * _Wave2Height;
    u_xlat2.x = u_xlat21 * _WaveFreq;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.0<u_xlat21);
#else
    u_xlatb21 = 0.0<u_xlat21;
#endif
    u_xlat7.x = u_xlat7.x * _WaveSpeed + (-u_xlat2.x);
    u_xlat2.x = sin(u_xlat7.x);
    u_xlat3.x = cos(u_xlat7.x);
    u_xlat0.x = _WaveHeight * u_xlat2.x + u_xlat0.x;
    u_xlat7.x = _WaveHeight * u_xlat3.x + u_xlat14;
    u_xlat2.x = u_xlat7.x * _WaveSlopeMag;
    u_xlat0.x = u_xlat0.x + in_POSITION0.y;
    u_xlat3 = u_xlat0.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat4 = u_xlat3 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat3 = u_xlat4.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat4.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat4.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat4.wwww + u_xlat3;
    gl_Position = u_xlat3;
    u_xlat0.x = u_xlat3.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Whitecaps_ST.xy + _Whitecaps_ST.zw;
    u_xlat2.y = 1.0;
    u_xlat7.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat2.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.z = (-u_xlat2.x);
    u_xlat3.y = dot(u_xlat2.yz, in_NORMAL0.yz);
    u_xlat2 = u_xlat1.xxyy * u_xlat2.xyxy;
    u_xlat5.x = (-u_xlat1.x);
    u_xlat5.yz = u_xlat2.zw;
    u_xlat1.zw = u_xlat2.xy;
    u_xlat3.x = dot(u_xlat1.yzw, in_NORMAL0.xyz);
    u_xlat3.z = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat1.xyz = u_xlat7.xxx * u_xlat3.xyz;
    u_xlat7.xyz = (bool(u_xlatb21)) ? u_xlat1.xyz : in_NORMAL0.xyz;
    u_xlat1.x = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(u_xlat7.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    vs_TEXCOORD1.xyz = u_xlat7.xxx * u_xlat1.xyz;
    u_xlat7.x = u_xlat4.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat4.x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat4.z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat4.w + u_xlat7.x;
    u_xlat7.x = abs(u_xlat7.x) + (-_WhitecapsDepthMin);
    u_xlat14 = (-_WhitecapsDepthMin) + _WhitecapsDepthMax;
    vs_TEXCOORD3 = u_xlat7.x / u_xlat14;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3 = min(max(vs_TEXCOORD3, 0.0), 1.0);
#else
    vs_TEXCOORD3 = clamp(vs_TEXCOORD3, 0.0, 1.0);
#endif
    u_xlat16_6 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat0.x, u_xlat16_6);
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
uniform 	mediump vec4 _LightColor0;
uniform 	vec4 booster_Env;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump float _AlbedoScrollSpeedU;
uniform 	mediump float _AlbedoScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSpeedU;
uniform 	mediump float _WhitecapsScrollSpeedV;
uniform 	mediump float _WhitecapsScrollSinScaleU;
uniform 	mediump float _WhitecapsScrollSinScaleV;
uniform 	mediump float _WhitecapsScrollSinSpeedU;
uniform 	mediump float _WhitecapsScrollSinSpeedV;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _Whitecaps;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD6;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_7;
vec2 u_xlat12;
mediump float u_xlat16_12;
float u_xlat18;
mediump float u_xlat16_22;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat18 = max(u_xlat18, 0.319999993);
    u_xlat16_1.x = (-_Smoothness) + 1.0;
    u_xlat16_7 = u_xlat16_1.x * u_xlat16_1.x + 1.5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat18 = u_xlat18 * u_xlat16_7;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat7.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat6 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_12 = u_xlat16_1.x * u_xlat16_1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_12 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat18;
    u_xlat0.x = u_xlat16_1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat12.xy = booster_Env.xx * vec2(_WhitecapsScrollSinSpeedU, _WhitecapsScrollSinSpeedV);
    u_xlat12.xy = sin(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy * vec2(_WhitecapsScrollSinScaleU, _WhitecapsScrollSinScaleV);
    u_xlat12.xy = vec2(_WhitecapsScrollSpeedU, _WhitecapsScrollSpeedV) * booster_Env.xx + u_xlat12.xy;
    u_xlat12.xy = fract(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy + vs_TEXCOORD0.zw;
    u_xlat16_1.xyz = texture(_Whitecaps, u_xlat12.xy).xyz;
    u_xlat12.xy = booster_Env.xx * vec2(_AlbedoScrollSpeedU, _AlbedoScrollSpeedV);
    u_xlat12.xy = fract(u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy + vs_TEXCOORD0.xy;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat12.xy).xyz;
    u_xlat16_3.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_5.xyz;
    u_xlat16_22 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat16_4.xyz * vec3(u_xlat16_22) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xzw;
    u_xlat18 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18);
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