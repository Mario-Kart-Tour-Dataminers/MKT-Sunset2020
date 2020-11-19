//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/StandardCustom/ドライバー/Character_MltMsk" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_AddColor ("加算色", Color) = (0,0,0,0)
_MinMSA ("Min MSA", Vector) = (0,0,0,0)
_MainTex ("Albedo(UV0)", 2D) = "white" { }
_MSA ("MSA Map(UV0)", 2D) = "black" { }
_Occlusion ("Occlusion", Range(0, 1)) = 1
_BumpMap ("Normalmap(UV0)", 2D) = "bump" { }
_SphereMap ("SphereMap", 2D) = "black" { }
_SphereMapScale ("SphereMap Scale", Vector) = (1,1,1,1)
_SphereMapMask ("SphereMapMask", 2D) = "white" { }
[Header(Booster Reflection Cube Map)] [KeywordEnum(NO,YES,FIXEDCOLOR)] _ReflectionProbeType ("個別リフレクションキューブマップ使用", Float) = 0
_HeuristicReflection ("個別リフレクションキューブマップ", Cube) = "_Skybox" { }
_NormalDiff ("疑似LOD反射の揺らぎ", Range(-1, 1)) = 0
_NormalRand ("疑似LOD乱数値", Vector) = (9993.169,5715.817,4488.509,34.2347)
_FixedReflColor ("単色リフレクションカラー", Color) = (1,1,1,1)
[Space(20)] [Enum(NO,0,YES,128)] _StencilOp ("置き影が落ちなくなる", Float) = 128
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
  GpuProgramID 35918
Program "vp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_11;
mediump float u_xlat16_13;
mediump float u_xlat16_24;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
bool u_xlatb34;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat33 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * _NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat3.xyz = vec3(u_xlat34) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat3.xyz * (-u_xlat16_2.xxx) + (-u_xlat0.xyz);
    u_xlat34 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat34<9.99999975e-06);
#else
    u_xlatb34 = u_xlat34<9.99999975e-06;
#endif
    u_xlat34 = (u_xlatb34) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat34 * u_xlat16_2.x;
    u_xlat5.x = u_xlat34 * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat4.xyz = vec3(u_xlat34) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33) + u_xlat16_2.xyz;
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_24 = u_xlat16_5.z + -1.0;
    u_xlat16_24 = _Occlusion * u_xlat16_24 + 1.0;
    u_xlat16_24 = max(u_xlat16_24, _MinMSA.z);
    u_xlat5.z = (-u_xlat16_2.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat5.z<0.00499999989);
#else
    u_xlatb33 = u_xlat5.z<0.00499999989;
#endif
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_35 = (u_xlatb33) ? 0.0 : u_xlat34;
    u_xlat16_4 = texture(unity_SpecCube0, u_xlat4.xyz, u_xlat16_35);
    u_xlat16_35 = u_xlat16_4.w + -1.0;
    u_xlat16_35 = unity_SpecCube0_HDR.w * u_xlat16_35 + 1.0;
    u_xlat16_35 = u_xlat16_35 * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * vec3(u_xlat16_35);
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_6.xyz;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xyz = texture(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * _SphereMapScale.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + _AddColor.xyz;
    u_xlat16_1.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_2.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_13 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_13 = u_xlat16_13 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_13);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat33)) + u_xlat0.xyz;
    u_xlat33 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = vec3(u_xlat33) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_13 = (-u_xlat1.x) + 1.0;
    u_xlat16_11 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_11 = u_xlat16_13 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_13 * u_xlat16_11;
    u_xlat16_9.xyz = vec3(u_xlat16_11) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat16_9.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat16_13 = roundEven(u_xlat16_24);
    u_xlat16_24 = u_xlat16_24 * 2.0 + -1.0;
    u_xlat16_2.xyw = (-u_xlat16_7.xyz) * u_xlat16_2.xxx + vec3(u_xlat16_13);
    u_xlat16_2.xyz = abs(vec3(u_xlat16_24)) * u_xlat16_2.xyw + u_xlat16_9.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_13;
float u_xlat20;
mediump float u_xlat16_23;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
mediump float u_xlat16_33;
mediump float u_xlat16_36;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat30 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD4.xyz, u_xlat16_3.xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot((-u_xlat11.xyz), u_xlat4.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat4.xyz * (-u_xlat16_3.xxx) + (-u_xlat11.xyz);
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_33 = (-u_xlat1.x) + 1.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat1.x = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat5.z = u_xlat1.x * u_xlat16_3.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_3.z;
    u_xlat5.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat1.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat5.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat1.xyz = vec3(u_xlat31) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat30) + u_xlat16_3.xyz;
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_3.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_23 = u_xlat16_5.z + -1.0;
    u_xlat16_23 = _Occlusion * u_xlat16_23 + 1.0;
    u_xlat16_23 = max(u_xlat16_23, _MinMSA.z);
    u_xlat30 = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat30<0.00499999989);
#else
    u_xlatb31 = u_xlat30<0.00499999989;
#endif
    u_xlat32 = u_xlat30 * 8.29800034;
    u_xlat16_6.x = (u_xlatb31) ? 0.0 : u_xlat32;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat1.xyz, u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_1.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = vec3(u_xlat16_23) * u_xlat16_6.xyz;
    u_xlat1.x = u_xlat30 * u_xlat30;
    u_xlat16_36 = u_xlat30 * u_xlat1.x;
    u_xlat30 = u_xlat30 * u_xlat30 + 1.5;
    u_xlat16_36 = (-u_xlat16_36) * 0.280000001 + 1.0;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_36);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_11.xyz = texture(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_11.xyz * _SphereMapScale.xyz;
    u_xlat16_11.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_11.xyz * u_xlat16_2.xyz + _AddColor.xyz;
    u_xlat16_11.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_13 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_13 = u_xlat16_13 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_13);
    u_xlat16_9.xyz = vec3(u_xlat16_33) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat11.xxx;
    u_xlat11.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat20 = max(u_xlat11.x, 0.319999993);
    u_xlat20 = u_xlat30 * u_xlat20;
    u_xlat30 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat30 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat20;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_9.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat10) + u_xlat16_6.xyz;
    u_xlat16_13 = roundEven(u_xlat16_23);
    u_xlat16_23 = u_xlat16_23 * 2.0 + -1.0;
    u_xlat16_3.xyw = (-u_xlat16_7.xyz) * u_xlat16_3.xxx + vec3(u_xlat16_13);
    u_xlat16_3.xyz = abs(vec3(u_xlat16_23)) * u_xlat16_3.xyw + u_xlat16_9.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_13;
float u_xlat20;
mediump float u_xlat16_23;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
mediump float u_xlat16_33;
mediump float u_xlat16_36;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat30 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD4.xyz, u_xlat16_3.xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot((-u_xlat11.xyz), u_xlat4.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat4.xyz * (-u_xlat16_3.xxx) + (-u_xlat11.xyz);
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_33 = (-u_xlat1.x) + 1.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat1.x = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat5.z = u_xlat1.x * u_xlat16_3.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_3.z;
    u_xlat5.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat1.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat5.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat1.xyz = vec3(u_xlat31) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat30) + u_xlat16_3.xyz;
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_3.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_23 = u_xlat16_5.z + -1.0;
    u_xlat16_23 = _Occlusion * u_xlat16_23 + 1.0;
    u_xlat16_23 = max(u_xlat16_23, _MinMSA.z);
    u_xlat30 = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat30<0.00499999989);
#else
    u_xlatb31 = u_xlat30<0.00499999989;
#endif
    u_xlat32 = u_xlat30 * 8.29800034;
    u_xlat16_6.x = (u_xlatb31) ? 0.0 : u_xlat32;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat1.xyz, u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_1.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = vec3(u_xlat16_23) * u_xlat16_6.xyz;
    u_xlat1.x = u_xlat30 * u_xlat30;
    u_xlat16_36 = u_xlat30 * u_xlat1.x;
    u_xlat30 = u_xlat30 * u_xlat30 + 1.5;
    u_xlat16_36 = (-u_xlat16_36) * 0.280000001 + 1.0;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_36);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_11.xyz = texture(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_11.xyz * _SphereMapScale.xyz;
    u_xlat16_11.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_11.xyz * u_xlat16_2.xyz + _AddColor.xyz;
    u_xlat16_11.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_13 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_13 = u_xlat16_13 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_13);
    u_xlat16_9.xyz = vec3(u_xlat16_33) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat11.xxx;
    u_xlat11.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat20 = max(u_xlat11.x, 0.319999993);
    u_xlat20 = u_xlat30 * u_xlat20;
    u_xlat30 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat30 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat20;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_9.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat10) + u_xlat16_6.xyz;
    u_xlat16_13 = roundEven(u_xlat16_23);
    u_xlat16_23 = u_xlat16_23 * 2.0 + -1.0;
    u_xlat16_3.xyw = (-u_xlat16_7.xyz) * u_xlat16_3.xxx + vec3(u_xlat16_13);
    u_xlat16_3.xyz = abs(vec3(u_xlat16_23)) * u_xlat16_3.xyw + u_xlat16_9.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
mediump float u_xlat16_15;
mediump float u_xlat16_27;
float u_xlat36;
bool u_xlatb36;
float u_xlat37;
bool u_xlatb37;
mediump float u_xlat16_39;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat36 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat36 = sin(u_xlat36);
    u_xlat36 = u_xlat36 * _NormalRand.w;
    u_xlat36 = fract(u_xlat36);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat37 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat2.xyz = vec3(u_xlat37) * u_xlat1.xyz;
    u_xlat16_3.x = dot((-u_xlat0.xyz), u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat2.xyz * (-u_xlat16_3.xxx) + (-u_xlat0.xyz);
    u_xlat37 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb37 = !!(u_xlat37<9.99999975e-06);
#else
    u_xlatb37 = u_xlat37<9.99999975e-06;
#endif
    u_xlat37 = (u_xlatb37) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat4.z = u_xlat37 * u_xlat16_3.x;
    u_xlat5.x = u_xlat37 * u_xlat16_3.z;
    u_xlat4.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat5.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat4.xyz = vec3(u_xlat37) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat36) + u_xlat16_3.xyz;
    u_xlat36 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat4.xyz = vec3(u_xlat36) * u_xlat4.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_3.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_27 = u_xlat16_5.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_27 = max(u_xlat16_27, _MinMSA.z);
    u_xlat5.z = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat5.z<0.00499999989);
#else
    u_xlatb36 = u_xlat5.z<0.00499999989;
#endif
    u_xlat37 = u_xlat5.z * 8.29800034;
    u_xlat16_39 = (u_xlatb36) ? 0.0 : u_xlat37;
    u_xlat16_4 = texture(unity_SpecCube0, u_xlat4.xyz, u_xlat16_39);
    u_xlat16_39 = u_xlat16_4.w + -1.0;
    u_xlat16_39 = unity_SpecCube0_HDR.w * u_xlat16_39 + 1.0;
    u_xlat16_39 = u_xlat16_39 * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * vec3(u_xlat16_39);
    u_xlat16_6.xyz = vec3(u_xlat16_27) * u_xlat16_6.xyz;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xyz = texture(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * _SphereMapScale.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + _AddColor.xyz;
    u_xlat16_1.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_15 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_15 = u_xlat16_15 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_15);
    u_xlat36 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat1.x = u_xlat36;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat36 = u_xlat36 + u_xlat36;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat36)) + u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat16_15 = (-u_xlat1.x) + 1.0;
    u_xlat16_12 = u_xlat16_15 * u_xlat16_15;
    u_xlat16_12 = u_xlat16_15 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_15 * u_xlat16_12;
    u_xlat16_9.xyz = vec3(u_xlat16_12) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = u_xlat12.xxx * _LightColor0.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_10.xyz = u_xlat16_10.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.yzw = log2(u_xlat16_10.xyz);
    u_xlat0 = u_xlat0 * vec4(16.0, 0.416666657, 0.416666657, 0.416666657);
    u_xlat12.xyz = exp2(u_xlat0.yzw);
    u_xlat12.xyz = u_xlat12.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat12.xyz = max(u_xlat12.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = vec3(u_xlat16_27) * u_xlat12.xyz;
    u_xlat16_11.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz * u_xlat16_11.xyz + u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_11.xyz;
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_9.xyz + u_xlat16_6.xyz;
    u_xlat16_15 = roundEven(u_xlat16_27);
    u_xlat16_27 = u_xlat16_27 * 2.0 + -1.0;
    u_xlat16_3.xyw = (-u_xlat16_7.xyz) * u_xlat16_3.xxx + vec3(u_xlat16_15);
    u_xlat16_3.xyz = abs(vec3(u_xlat16_27)) * u_xlat16_3.xyw + u_xlat16_11.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_6.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
bool u_xlatb11;
mediump vec3 u_xlat16_13;
float u_xlat14;
mediump float u_xlat16_24;
float u_xlat25;
float u_xlat33;
mediump float u_xlat16_35;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat16_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.x = u_xlat16_4.z + -1.0;
    u_xlat16_13.xy = max(u_xlat16_4.xy, _MinMSA.xy);
    u_xlat16_2.x = _Occlusion * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, _MinMSA.z);
    u_xlat16_5.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + _AddColor.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_35 = (-u_xlat16_13.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_35) * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_13.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat4.xyz = u_xlat3.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat36 = dot(u_xlat1.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat14 = u_xlat36 * u_xlat36;
    u_xlat25 = (-u_xlat16_13.y) + 1.0;
    u_xlat16_13.x = (-u_xlat16_35) + u_xlat16_13.y;
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13.x = min(max(u_xlat16_13.x, 0.0), 1.0);
#else
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + u_xlat16_13.xxx;
    u_xlat36 = u_xlat25 * u_xlat25;
    u_xlat4.x = u_xlat36 * u_xlat36 + -1.0;
    u_xlat14 = u_xlat14 * u_xlat4.x + 1.00001001;
    u_xlat4.x = u_xlat25 * u_xlat25 + 1.5;
    u_xlat3.x = u_xlat3.x * u_xlat4.x;
    u_xlat3.x = u_xlat14 * u_xlat3.x;
    u_xlat3.x = u_xlat36 / u_xlat3.x;
    u_xlat16_13.x = u_xlat25 * u_xlat36;
    u_xlat16_13.x = (-u_xlat16_13.x) * 0.280000001 + 1.0;
    u_xlat3.x = u_xlat3.x + -9.99999975e-05;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = min(u_xlat3.x, 100.0);
    u_xlat3.xyw = u_xlat3.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat3.xyw = u_xlat3.xyw * _LightColor0.xyz;
    u_xlat4.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat3.xyw = u_xlat3.xyw * u_xlat4.xxx + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat25<0.00499999989);
#else
    u_xlatb4 = u_xlat25<0.00499999989;
#endif
    u_xlat25 = u_xlat25 * 8.29800034;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat25;
    u_xlat16_5.x = dot((-u_xlat11.xyz), u_xlat1.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat1.xyz * (-u_xlat16_5.xxx) + (-u_xlat11.xyz);
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat11.x) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat11.x = dot(u_xlat16_5.zxy, (-u_xlat16_5.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat11.x<9.99999975e-06);
#else
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
#endif
    u_xlat11.x = (u_xlatb11) ? u_xlat16_5.z : (-u_xlat16_5.z);
    u_xlat4.z = u_xlat11.x * u_xlat16_5.x;
    u_xlat10.x = u_xlat11.x * u_xlat16_5.z;
    u_xlat4.xy = (-u_xlat16_5.xy) * u_xlat16_5.yz;
    u_xlat10.yz = (-u_xlat16_5.xy) * u_xlat16_5.xy;
    u_xlat11.xyz = u_xlat4.xyz + (-u_xlat10.xyz);
    u_xlat25 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat25);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat11.xyz * u_xlat0.xxx + u_xlat16_5.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_24);
    u_xlat16_24 = u_xlat16_0.w + -1.0;
    u_xlat16_24 = unity_SpecCube0_HDR.w * u_xlat16_24 + 1.0;
    u_xlat16_24 = u_xlat16_24 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_0.xyz * vec3(u_xlat16_24);
    u_xlat16_5.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_13.xxx * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat3.xyw;
    u_xlat16_13.x = roundEven(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * 2.0 + -1.0;
    u_xlat16_13.xyz = (-u_xlat16_6.xyz) * vec3(u_xlat16_35) + u_xlat16_13.xxx;
    u_xlat16_2.xyz = abs(u_xlat16_2.xxx) * u_xlat16_13.xyz + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
bool u_xlatb11;
mediump vec3 u_xlat16_13;
float u_xlat14;
mediump float u_xlat16_24;
float u_xlat25;
float u_xlat33;
mediump float u_xlat16_35;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat16_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.x = u_xlat16_4.z + -1.0;
    u_xlat16_13.xy = max(u_xlat16_4.xy, _MinMSA.xy);
    u_xlat16_2.x = _Occlusion * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, _MinMSA.z);
    u_xlat16_5.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + _AddColor.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_35 = (-u_xlat16_13.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_35) * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_13.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat4.xyz = u_xlat3.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat36 = dot(u_xlat1.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat14 = u_xlat36 * u_xlat36;
    u_xlat25 = (-u_xlat16_13.y) + 1.0;
    u_xlat16_13.x = (-u_xlat16_35) + u_xlat16_13.y;
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13.x = min(max(u_xlat16_13.x, 0.0), 1.0);
#else
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + u_xlat16_13.xxx;
    u_xlat36 = u_xlat25 * u_xlat25;
    u_xlat4.x = u_xlat36 * u_xlat36 + -1.0;
    u_xlat14 = u_xlat14 * u_xlat4.x + 1.00001001;
    u_xlat4.x = u_xlat25 * u_xlat25 + 1.5;
    u_xlat3.x = u_xlat3.x * u_xlat4.x;
    u_xlat3.x = u_xlat14 * u_xlat3.x;
    u_xlat3.x = u_xlat36 / u_xlat3.x;
    u_xlat16_13.x = u_xlat25 * u_xlat36;
    u_xlat16_13.x = (-u_xlat16_13.x) * 0.280000001 + 1.0;
    u_xlat3.x = u_xlat3.x + -9.99999975e-05;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = min(u_xlat3.x, 100.0);
    u_xlat3.xyw = u_xlat3.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat3.xyw = u_xlat3.xyw * _LightColor0.xyz;
    u_xlat4.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat3.xyw = u_xlat3.xyw * u_xlat4.xxx + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat25<0.00499999989);
#else
    u_xlatb4 = u_xlat25<0.00499999989;
#endif
    u_xlat25 = u_xlat25 * 8.29800034;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat25;
    u_xlat16_5.x = dot((-u_xlat11.xyz), u_xlat1.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat1.xyz * (-u_xlat16_5.xxx) + (-u_xlat11.xyz);
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat11.x) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat11.x = dot(u_xlat16_5.zxy, (-u_xlat16_5.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat11.x<9.99999975e-06);
#else
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
#endif
    u_xlat11.x = (u_xlatb11) ? u_xlat16_5.z : (-u_xlat16_5.z);
    u_xlat4.z = u_xlat11.x * u_xlat16_5.x;
    u_xlat10.x = u_xlat11.x * u_xlat16_5.z;
    u_xlat4.xy = (-u_xlat16_5.xy) * u_xlat16_5.yz;
    u_xlat10.yz = (-u_xlat16_5.xy) * u_xlat16_5.xy;
    u_xlat11.xyz = u_xlat4.xyz + (-u_xlat10.xyz);
    u_xlat25 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat25);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat11.xyz * u_xlat0.xxx + u_xlat16_5.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_24);
    u_xlat16_24 = u_xlat16_0.w + -1.0;
    u_xlat16_24 = unity_SpecCube0_HDR.w * u_xlat16_24 + 1.0;
    u_xlat16_24 = u_xlat16_24 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_0.xyz * vec3(u_xlat16_24);
    u_xlat16_5.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_13.xxx * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat3.xyw;
    u_xlat16_13.x = roundEven(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * 2.0 + -1.0;
    u_xlat16_13.xyz = (-u_xlat16_6.xyz) * vec3(u_xlat16_35) + u_xlat16_13.xxx;
    u_xlat16_2.xyz = abs(u_xlat16_2.xxx) * u_xlat16_13.xyz + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_TEXCOORD7.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
mediump float u_xlat16_14;
mediump float u_xlat16_25;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
bool u_xlatb34;
mediump float u_xlat16_36;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat33 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * _NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat2.xyz = vec3(u_xlat34) * u_xlat1.xyz;
    u_xlat16_3.x = dot((-u_xlat0.xyz), u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat2.xyz * (-u_xlat16_3.xxx) + (-u_xlat0.xyz);
    u_xlat34 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat34<9.99999975e-06);
#else
    u_xlatb34 = u_xlat34<9.99999975e-06;
#endif
    u_xlat34 = (u_xlatb34) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat4.z = u_xlat34 * u_xlat16_3.x;
    u_xlat5.x = u_xlat34 * u_xlat16_3.z;
    u_xlat4.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat5.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat4.xyz = vec3(u_xlat34) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33) + u_xlat16_3.xyz;
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_3.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_25 = u_xlat16_5.z + -1.0;
    u_xlat16_25 = _Occlusion * u_xlat16_25 + 1.0;
    u_xlat16_25 = max(u_xlat16_25, _MinMSA.z);
    u_xlat5.z = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat5.z<0.00499999989);
#else
    u_xlatb33 = u_xlat5.z<0.00499999989;
#endif
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_36 = (u_xlatb33) ? 0.0 : u_xlat34;
    u_xlat16_4 = texture(unity_SpecCube0, u_xlat4.xyz, u_xlat16_36);
    u_xlat16_36 = u_xlat16_4.w + -1.0;
    u_xlat16_36 = unity_SpecCube0_HDR.w * u_xlat16_36 + 1.0;
    u_xlat16_36 = u_xlat16_36 * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * vec3(u_xlat16_36);
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xyz = texture(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * _SphereMapScale.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + _AddColor.xyz;
    u_xlat16_1.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_14 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_14 = u_xlat16_14 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_14);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat1.x = u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat33)) + u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_14 = (-u_xlat1.x) + 1.0;
    u_xlat16_11 = u_xlat16_14 * u_xlat16_14;
    u_xlat16_11 = u_xlat16_14 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_14 * u_xlat16_11;
    u_xlat16_9.xyz = vec3(u_xlat16_11) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat11 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    u_xlat16_10.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_9.xyz * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_14 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_14) * _LightColor0.xyz;
    u_xlat16_9.xyz = vec3(u_xlat11) * u_xlat16_9.xyz;
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_9.xyz + u_xlat16_6.xyz;
    u_xlat16_14 = roundEven(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * 2.0 + -1.0;
    u_xlat16_3.xyw = (-u_xlat16_7.xyz) * u_xlat16_3.xxx + vec3(u_xlat16_14);
    u_xlat16_3.xyz = abs(vec3(u_xlat16_25)) * u_xlat16_3.xyw + u_xlat16_10.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_6.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_TEXCOORD7.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
vec3 u_xlat12;
float u_xlat16;
float u_xlat26;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
float u_xlat36;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + _AddColor.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat16_4.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat16_4.xyz);
    u_xlat2.z = dot(vs_TEXCOORD4.xyz, u_xlat16_4.xyz);
    u_xlat16_4.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xy = max(u_xlat16_0.xy, _MinMSA.xy);
    u_xlat16_31 = u_xlat16_0.z + -1.0;
    u_xlat16_31 = _Occlusion * u_xlat16_31 + 1.0;
    u_xlat16_31 = max(u_xlat16_31, _MinMSA.z);
    u_xlat16_4.xyz = u_xlat16_5.xxx * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_33 = (-u_xlat16_5.x) * 0.779083729 + 0.779083729;
    u_xlat16_5.xzw = vec3(u_xlat16_33) * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat2.x = vs_TEXCOORD2.w;
    u_xlat2.y = vs_TEXCOORD3.w;
    u_xlat2.z = vs_TEXCOORD4.w;
    u_xlat6.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _NormalRand.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat12.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat7.xyz = u_xlat6.xyz * u_xlat12.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat12.xyz = u_xlat12.xxx * u_xlat6.xyz;
    u_xlat6.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat6.x = max(u_xlat6.x, 0.00100000005);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat7.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat6.x = dot(_WorldSpaceLightPos0.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat6.x = max(u_xlat6.x, 0.319999993);
    u_xlat16 = u_xlat36 * u_xlat36;
    u_xlat26 = (-u_xlat16_5.y) + 1.0;
    u_xlat16_34 = (-u_xlat16_33) + u_xlat16_5.y;
    u_xlat16_34 = u_xlat16_34 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_34);
    u_xlat36 = u_xlat26 * u_xlat26;
    u_xlat7.x = u_xlat36 * u_xlat36 + -1.0;
    u_xlat16 = u_xlat16 * u_xlat7.x + 1.00001001;
    u_xlat7.x = u_xlat26 * u_xlat26 + 1.5;
    u_xlat6.x = u_xlat6.x * u_xlat7.x;
    u_xlat6.x = u_xlat16 * u_xlat6.x;
    u_xlat6.x = u_xlat36 / u_xlat6.x;
    u_xlat16_34 = u_xlat26 * u_xlat36;
    u_xlat16_34 = (-u_xlat16_34) * 0.280000001 + 1.0;
    u_xlat6.x = u_xlat6.x + -9.99999975e-05;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat6.x = min(u_xlat6.x, 100.0);
    u_xlat6.xyw = u_xlat6.xxx * u_xlat16_4.xyz + u_xlat16_5.xzw;
    u_xlat6.xyw = u_xlat16_1.xyz * u_xlat6.xyw;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_7.xyz = exp2(u_xlat16_7.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xzw * u_xlat16_1.xyz;
    u_xlat30 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat6.xyw = u_xlat6.xyw * vec3(u_xlat30) + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat26<0.00499999989);
#else
    u_xlatb30 = u_xlat26<0.00499999989;
#endif
    u_xlat26 = u_xlat26 * 8.29800034;
    u_xlat16_1.x = (u_xlatb30) ? 0.0 : u_xlat26;
    u_xlat16_11 = dot((-u_xlat12.xyz), u_xlat0.xyz);
    u_xlat16_11 = u_xlat16_11 + u_xlat16_11;
    u_xlat16_9.xyz = u_xlat0.xyz * (-vec3(u_xlat16_11)) + (-u_xlat12.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat0.x) + 1.0;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_4.xyz = vec3(u_xlat16_11) * u_xlat16_8.xyz + u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat16_9.zxy, (-u_xlat16_9.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<9.99999975e-06);
#else
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
#endif
    u_xlat0.x = (u_xlatb0) ? u_xlat16_9.z : (-u_xlat16_9.z);
    u_xlat7.z = u_xlat0.x * u_xlat16_9.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_9.z;
    u_xlat7.xy = (-u_xlat16_9.xy) * u_xlat16_9.yz;
    u_xlat0.yz = (-u_xlat16_9.xy) * u_xlat16_9.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat7.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_34);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + u_xlat6.xyw;
    u_xlat16_1.x = roundEven(u_xlat16_31);
    u_xlat16_11 = u_xlat16_31 * 2.0 + -1.0;
    u_xlat16_1.xzw = (-u_xlat16_3.xyz) * vec3(u_xlat16_33) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = abs(vec3(u_xlat16_11)) * u_xlat16_1.xzw + u_xlat16_5.xzw;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_0 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    vs_TEXCOORD7.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
vec3 u_xlat12;
float u_xlat16;
float u_xlat26;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
float u_xlat36;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + _AddColor.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat16_4.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat16_4.xyz);
    u_xlat2.z = dot(vs_TEXCOORD4.xyz, u_xlat16_4.xyz);
    u_xlat16_4.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xy = max(u_xlat16_0.xy, _MinMSA.xy);
    u_xlat16_31 = u_xlat16_0.z + -1.0;
    u_xlat16_31 = _Occlusion * u_xlat16_31 + 1.0;
    u_xlat16_31 = max(u_xlat16_31, _MinMSA.z);
    u_xlat16_4.xyz = u_xlat16_5.xxx * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_33 = (-u_xlat16_5.x) * 0.779083729 + 0.779083729;
    u_xlat16_5.xzw = vec3(u_xlat16_33) * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat2.x = vs_TEXCOORD2.w;
    u_xlat2.y = vs_TEXCOORD3.w;
    u_xlat2.z = vs_TEXCOORD4.w;
    u_xlat6.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _NormalRand.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat12.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat7.xyz = u_xlat6.xyz * u_xlat12.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat12.xyz = u_xlat12.xxx * u_xlat6.xyz;
    u_xlat6.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat6.x = max(u_xlat6.x, 0.00100000005);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat7.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat6.x = dot(_WorldSpaceLightPos0.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat6.x = max(u_xlat6.x, 0.319999993);
    u_xlat16 = u_xlat36 * u_xlat36;
    u_xlat26 = (-u_xlat16_5.y) + 1.0;
    u_xlat16_34 = (-u_xlat16_33) + u_xlat16_5.y;
    u_xlat16_34 = u_xlat16_34 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_34);
    u_xlat36 = u_xlat26 * u_xlat26;
    u_xlat7.x = u_xlat36 * u_xlat36 + -1.0;
    u_xlat16 = u_xlat16 * u_xlat7.x + 1.00001001;
    u_xlat7.x = u_xlat26 * u_xlat26 + 1.5;
    u_xlat6.x = u_xlat6.x * u_xlat7.x;
    u_xlat6.x = u_xlat16 * u_xlat6.x;
    u_xlat6.x = u_xlat36 / u_xlat6.x;
    u_xlat16_34 = u_xlat26 * u_xlat36;
    u_xlat16_34 = (-u_xlat16_34) * 0.280000001 + 1.0;
    u_xlat6.x = u_xlat6.x + -9.99999975e-05;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat6.x = min(u_xlat6.x, 100.0);
    u_xlat6.xyw = u_xlat6.xxx * u_xlat16_4.xyz + u_xlat16_5.xzw;
    u_xlat6.xyw = u_xlat16_1.xyz * u_xlat6.xyw;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_7.xyz = exp2(u_xlat16_7.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xzw * u_xlat16_1.xyz;
    u_xlat30 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat6.xyw = u_xlat6.xyw * vec3(u_xlat30) + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat26<0.00499999989);
#else
    u_xlatb30 = u_xlat26<0.00499999989;
#endif
    u_xlat26 = u_xlat26 * 8.29800034;
    u_xlat16_1.x = (u_xlatb30) ? 0.0 : u_xlat26;
    u_xlat16_11 = dot((-u_xlat12.xyz), u_xlat0.xyz);
    u_xlat16_11 = u_xlat16_11 + u_xlat16_11;
    u_xlat16_9.xyz = u_xlat0.xyz * (-vec3(u_xlat16_11)) + (-u_xlat12.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat0.x) + 1.0;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_4.xyz = vec3(u_xlat16_11) * u_xlat16_8.xyz + u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat16_9.zxy, (-u_xlat16_9.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<9.99999975e-06);
#else
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
#endif
    u_xlat0.x = (u_xlatb0) ? u_xlat16_9.z : (-u_xlat16_9.z);
    u_xlat7.z = u_xlat0.x * u_xlat16_9.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_9.z;
    u_xlat7.xy = (-u_xlat16_9.xy) * u_xlat16_9.yz;
    u_xlat0.yz = (-u_xlat16_9.xy) * u_xlat16_9.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat7.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_34);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + u_xlat6.xyw;
    u_xlat16_1.x = roundEven(u_xlat16_31);
    u_xlat16_11 = u_xlat16_31 * 2.0 + -1.0;
    u_xlat16_1.xzw = (-u_xlat16_3.xyz) * vec3(u_xlat16_33) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = abs(vec3(u_xlat16_11)) * u_xlat16_1.xzw + u_xlat16_5.xzw;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_14;
mediump float u_xlat16_26;
float u_xlat36;
bool u_xlatb36;
float u_xlat37;
bool u_xlatb37;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat36 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat36 = sin(u_xlat36);
    u_xlat36 = u_xlat36 * _NormalRand.w;
    u_xlat36 = fract(u_xlat36);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat37 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat3.xyz = vec3(u_xlat37) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat3.xyz * (-u_xlat16_2.xxx) + (-u_xlat0.xyz);
    u_xlat37 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb37 = !!(u_xlat37<9.99999975e-06);
#else
    u_xlatb37 = u_xlat37<9.99999975e-06;
#endif
    u_xlat37 = (u_xlatb37) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat37 * u_xlat16_2.x;
    u_xlat5.x = u_xlat37 * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat4.xyz = vec3(u_xlat37) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat36) + u_xlat16_2.xyz;
    u_xlat36 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat4.xyz = vec3(u_xlat36) * u_xlat4.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_26 = u_xlat16_5.z + -1.0;
    u_xlat16_26 = _Occlusion * u_xlat16_26 + 1.0;
    u_xlat16_26 = max(u_xlat16_26, _MinMSA.z);
    u_xlat5.z = (-u_xlat16_2.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat5.z<0.00499999989);
#else
    u_xlatb36 = u_xlat5.z<0.00499999989;
#endif
    u_xlat37 = u_xlat5.z * 8.29800034;
    u_xlat16_38 = (u_xlatb36) ? 0.0 : u_xlat37;
    u_xlat16_4 = texture(unity_SpecCube0, u_xlat4.xyz, u_xlat16_38);
    u_xlat16_38 = u_xlat16_4.w + -1.0;
    u_xlat16_38 = unity_SpecCube0_HDR.w * u_xlat16_38 + 1.0;
    u_xlat16_38 = u_xlat16_38 * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * vec3(u_xlat16_38);
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xyz = texture(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * _SphereMapScale.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + _AddColor.xyz;
    u_xlat16_1.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_2.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_14 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_14 = u_xlat16_14 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_14);
    u_xlat36 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat36;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat36 = u_xlat36 + u_xlat36;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat36)) + u_xlat0.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = vec3(u_xlat36) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_14 = (-u_xlat1.x) + 1.0;
    u_xlat16_12.x = u_xlat16_14 * u_xlat16_14;
    u_xlat16_12.x = u_xlat16_14 * u_xlat16_12.x;
    u_xlat16_12.x = u_xlat16_14 * u_xlat16_12.x;
    u_xlat16_9.xyz = u_xlat16_12.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat16_12.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_12.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = vec3(u_xlat16_26) * u_xlat16_9.xyz;
    u_xlat16_11.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_9.xyz * u_xlat16_11.xyz + u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_11.xyz;
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat16_14 = roundEven(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * 2.0 + -1.0;
    u_xlat16_2.xyw = (-u_xlat16_7.xyz) * u_xlat16_2.xxx + vec3(u_xlat16_14);
    u_xlat16_2.xyz = abs(vec3(u_xlat16_26)) * u_xlat16_2.xyw + u_xlat16_11.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat10;
mediump vec3 u_xlat16_13;
float u_xlat19;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
float u_xlat32;
bool u_xlatb32;
mediump float u_xlat16_33;
mediump float u_xlat16_35;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz + _AddColor.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_3.xyz);
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_3.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_4.xy = max(u_xlat16_0.xy, _MinMSA.xy);
    u_xlat16_29 = u_xlat16_0.z + -1.0;
    u_xlat16_29 = _Occlusion * u_xlat16_29 + 1.0;
    u_xlat16_29 = max(u_xlat16_29, _MinMSA.z);
    u_xlat16_3.xyz = u_xlat16_4.xxx * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.y = vs_TEXCOORD3.w;
    u_xlat1.z = vs_TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat10.xyz = u_xlat5.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat10.x = u_xlat28 * u_xlat28;
    u_xlat19 = (-u_xlat16_4.y) + 1.0;
    u_xlat28 = u_xlat19 * u_xlat19;
    u_xlat32 = u_xlat28 * u_xlat28 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat32 + 1.00001001;
    u_xlat32 = u_xlat19 * u_xlat19 + 1.5;
    u_xlat1.x = u_xlat1.x * u_xlat32;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat28 / u_xlat1.x;
    u_xlat16_30 = u_xlat19 * u_xlat28;
    u_xlat16_30 = (-u_xlat16_30) * 0.280000001 + 1.0;
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat16_4.x = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_13.x = (-u_xlat16_4.x) + u_xlat16_4.y;
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13.x = min(max(u_xlat16_13.x, 0.0), 1.0);
#else
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0, 1.0);
#endif
    u_xlat16_13.xyz = (-u_xlat16_3.xyz) + u_xlat16_13.xxx;
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xxx;
    u_xlat1.xyw = u_xlat1.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat1.xyw = u_xlat1.xyw * _LightColor0.xyz;
    u_xlat16_7.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = vec3(u_xlat16_29) * u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz;
    u_xlat32 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat1.xyw = u_xlat1.xyw * vec3(u_xlat32) + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(u_xlat19<0.00499999989);
#else
    u_xlatb32 = u_xlat19<0.00499999989;
#endif
    u_xlat19 = u_xlat19 * 8.29800034;
    u_xlat16_33 = (u_xlatb32) ? 0.0 : u_xlat19;
    u_xlat16_8.x = dot((-u_xlat5.xyz), u_xlat0.xyz);
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_8.x;
    u_xlat16_8.xyz = u_xlat0.xyz * (-u_xlat16_8.xxx) + (-u_xlat5.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat0.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_3.xyz = vec3(u_xlat16_35) * u_xlat16_13.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat16_8.zxy, (-u_xlat16_8.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<9.99999975e-06);
#else
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
#endif
    u_xlat0.x = (u_xlatb0) ? u_xlat16_8.z : (-u_xlat16_8.z);
    u_xlat5.z = u_xlat0.x * u_xlat16_8.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_8.z;
    u_xlat5.xy = (-u_xlat16_8.xy) * u_xlat16_8.yz;
    u_xlat0.yz = (-u_xlat16_8.xy) * u_xlat16_8.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat16_8.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_33);
    u_xlat16_13.x = u_xlat16_0.w + -1.0;
    u_xlat16_13.x = unity_SpecCube0_HDR.w * u_xlat16_13.x + 1.0;
    u_xlat16_13.x = u_xlat16_13.x * unity_SpecCube0_HDR.x;
    u_xlat16_13.xyz = u_xlat16_0.xyz * u_xlat16_13.xxx;
    u_xlat16_13.xyz = vec3(u_xlat16_29) * u_xlat16_13.xyz;
    u_xlat16_13.xyz = vec3(u_xlat16_30) * u_xlat16_13.xyz;
    u_xlat0.xyz = u_xlat16_13.xyz * u_xlat16_3.xyz + u_xlat1.xyw;
    u_xlat16_3.x = roundEven(u_xlat16_29);
    u_xlat16_29 = u_xlat16_29 * 2.0 + -1.0;
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_4.xxx + u_xlat16_3.xxx;
    u_xlat16_2.xyz = abs(vec3(u_xlat16_29)) * u_xlat16_2.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat10;
mediump vec3 u_xlat16_13;
float u_xlat19;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
float u_xlat32;
bool u_xlatb32;
mediump float u_xlat16_33;
mediump float u_xlat16_35;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz + _AddColor.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_3.xyz);
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_3.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_4.xy = max(u_xlat16_0.xy, _MinMSA.xy);
    u_xlat16_29 = u_xlat16_0.z + -1.0;
    u_xlat16_29 = _Occlusion * u_xlat16_29 + 1.0;
    u_xlat16_29 = max(u_xlat16_29, _MinMSA.z);
    u_xlat16_3.xyz = u_xlat16_4.xxx * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.y = vs_TEXCOORD3.w;
    u_xlat1.z = vs_TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat10.xyz = u_xlat5.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat10.x = u_xlat28 * u_xlat28;
    u_xlat19 = (-u_xlat16_4.y) + 1.0;
    u_xlat28 = u_xlat19 * u_xlat19;
    u_xlat32 = u_xlat28 * u_xlat28 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat32 + 1.00001001;
    u_xlat32 = u_xlat19 * u_xlat19 + 1.5;
    u_xlat1.x = u_xlat1.x * u_xlat32;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat28 / u_xlat1.x;
    u_xlat16_30 = u_xlat19 * u_xlat28;
    u_xlat16_30 = (-u_xlat16_30) * 0.280000001 + 1.0;
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat16_4.x = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_13.x = (-u_xlat16_4.x) + u_xlat16_4.y;
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13.x = min(max(u_xlat16_13.x, 0.0), 1.0);
#else
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0, 1.0);
#endif
    u_xlat16_13.xyz = (-u_xlat16_3.xyz) + u_xlat16_13.xxx;
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xxx;
    u_xlat1.xyw = u_xlat1.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat1.xyw = u_xlat1.xyw * _LightColor0.xyz;
    u_xlat16_7.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = vec3(u_xlat16_29) * u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz;
    u_xlat32 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat1.xyw = u_xlat1.xyw * vec3(u_xlat32) + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(u_xlat19<0.00499999989);
#else
    u_xlatb32 = u_xlat19<0.00499999989;
#endif
    u_xlat19 = u_xlat19 * 8.29800034;
    u_xlat16_33 = (u_xlatb32) ? 0.0 : u_xlat19;
    u_xlat16_8.x = dot((-u_xlat5.xyz), u_xlat0.xyz);
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_8.x;
    u_xlat16_8.xyz = u_xlat0.xyz * (-u_xlat16_8.xxx) + (-u_xlat5.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat0.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_3.xyz = vec3(u_xlat16_35) * u_xlat16_13.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat16_8.zxy, (-u_xlat16_8.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<9.99999975e-06);
#else
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
#endif
    u_xlat0.x = (u_xlatb0) ? u_xlat16_8.z : (-u_xlat16_8.z);
    u_xlat5.z = u_xlat0.x * u_xlat16_8.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_8.z;
    u_xlat5.xy = (-u_xlat16_8.xy) * u_xlat16_8.yz;
    u_xlat0.yz = (-u_xlat16_8.xy) * u_xlat16_8.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat16_8.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_33);
    u_xlat16_13.x = u_xlat16_0.w + -1.0;
    u_xlat16_13.x = unity_SpecCube0_HDR.w * u_xlat16_13.x + 1.0;
    u_xlat16_13.x = u_xlat16_13.x * unity_SpecCube0_HDR.x;
    u_xlat16_13.xyz = u_xlat16_0.xyz * u_xlat16_13.xxx;
    u_xlat16_13.xyz = vec3(u_xlat16_29) * u_xlat16_13.xyz;
    u_xlat16_13.xyz = vec3(u_xlat16_30) * u_xlat16_13.xyz;
    u_xlat0.xyz = u_xlat16_13.xyz * u_xlat16_3.xyz + u_xlat1.xyw;
    u_xlat16_3.x = roundEven(u_xlat16_29);
    u_xlat16_29 = u_xlat16_29 * 2.0 + -1.0;
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_4.xxx + u_xlat16_3.xxx;
    u_xlat16_2.xyz = abs(vec3(u_xlat16_29)) * u_xlat16_2.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
mediump float u_xlat16_15;
mediump float u_xlat16_27;
float u_xlat36;
bool u_xlatb36;
float u_xlat37;
bool u_xlatb37;
mediump float u_xlat16_39;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat36 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat36 = sin(u_xlat36);
    u_xlat36 = u_xlat36 * _NormalRand.w;
    u_xlat36 = fract(u_xlat36);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat37 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat2.xyz = vec3(u_xlat37) * u_xlat1.xyz;
    u_xlat16_3.x = dot((-u_xlat0.xyz), u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat2.xyz * (-u_xlat16_3.xxx) + (-u_xlat0.xyz);
    u_xlat37 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb37 = !!(u_xlat37<9.99999975e-06);
#else
    u_xlatb37 = u_xlat37<9.99999975e-06;
#endif
    u_xlat37 = (u_xlatb37) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat4.z = u_xlat37 * u_xlat16_3.x;
    u_xlat5.x = u_xlat37 * u_xlat16_3.z;
    u_xlat4.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat5.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat4.xyz = vec3(u_xlat37) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat36) + u_xlat16_3.xyz;
    u_xlat36 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat4.xyz = vec3(u_xlat36) * u_xlat4.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_3.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_27 = u_xlat16_5.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_27 = max(u_xlat16_27, _MinMSA.z);
    u_xlat5.z = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat5.z<0.00499999989);
#else
    u_xlatb36 = u_xlat5.z<0.00499999989;
#endif
    u_xlat37 = u_xlat5.z * 8.29800034;
    u_xlat16_39 = (u_xlatb36) ? 0.0 : u_xlat37;
    u_xlat16_4 = texture(unity_SpecCube0, u_xlat4.xyz, u_xlat16_39);
    u_xlat16_39 = u_xlat16_4.w + -1.0;
    u_xlat16_39 = unity_SpecCube0_HDR.w * u_xlat16_39 + 1.0;
    u_xlat16_39 = u_xlat16_39 * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * vec3(u_xlat16_39);
    u_xlat16_6.xyz = vec3(u_xlat16_27) * u_xlat16_6.xyz;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xyz = texture(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * _SphereMapScale.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + _AddColor.xyz;
    u_xlat16_1.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_15 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_15 = u_xlat16_15 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_15);
    u_xlat36 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat1.x = u_xlat36;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat36 = u_xlat36 + u_xlat36;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat36)) + u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat16_15 = (-u_xlat1.x) + 1.0;
    u_xlat16_12 = u_xlat16_15 * u_xlat16_15;
    u_xlat16_12 = u_xlat16_15 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_15 * u_xlat16_12;
    u_xlat16_9.xyz = vec3(u_xlat16_12) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat16_15 = u_xlat2.y * u_xlat2.y;
    u_xlat16_15 = u_xlat2.x * u_xlat2.x + (-u_xlat16_15);
    u_xlat16_1 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_15) + u_xlat16_9.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = u_xlat12.xxx * _LightColor0.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_11.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_11.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_11.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_11.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.yzw = log2(u_xlat16_9.xyz);
    u_xlat0 = u_xlat0 * vec4(16.0, 0.416666657, 0.416666657, 0.416666657);
    u_xlat12.xyz = exp2(u_xlat0.yzw);
    u_xlat12.xyz = u_xlat12.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat12.xyz = max(u_xlat12.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat12.xyz;
    u_xlat16_9.xyz = vec3(u_xlat16_27) * u_xlat16_9.xyz;
    u_xlat16_11.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_9.xyz * u_xlat16_11.xyz + u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_11.xyz;
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat16_15 = roundEven(u_xlat16_27);
    u_xlat16_27 = u_xlat16_27 * 2.0 + -1.0;
    u_xlat16_3.xyw = (-u_xlat16_7.xyz) * u_xlat16_3.xxx + vec3(u_xlat16_15);
    u_xlat16_3.xyz = abs(vec3(u_xlat16_27)) * u_xlat16_3.xyw + u_xlat16_11.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_6.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
bool u_xlatb6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
float u_xlat16;
mediump vec2 u_xlat16_25;
float u_xlat27;
float u_xlat33;
mediump float u_xlat16_35;
mediump float u_xlat16_37;
float u_xlat38;
void main()
{
    u_xlat16_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_2.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_2.x);
    u_xlat16_3 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_5.xyz = exp2(u_xlat16_5.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_35 = u_xlat16_5.z + -1.0;
    u_xlat16_3.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_35 = _Occlusion * u_xlat16_35 + 1.0;
    u_xlat16_35 = max(u_xlat16_35, _MinMSA.z);
    u_xlat16_2.xyz = vec3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat16_25.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_25.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz + _AddColor.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_25.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_25.xxx * u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat6.xyz = u_xlat5.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat11.xyz = u_xlat11.xxx * u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat6.xyz;
    u_xlat38 = dot(u_xlat1.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat16 = u_xlat38 * u_xlat38;
    u_xlat27 = (-u_xlat16_3.y) + 1.0;
    u_xlat16_3.x = (-u_xlat16_25.x) + u_xlat16_3.y;
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyw = (-u_xlat16_8.xyz) + u_xlat16_3.xxx;
    u_xlat38 = u_xlat27 * u_xlat27;
    u_xlat6.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat16 = u_xlat16 * u_xlat6.x + 1.00001001;
    u_xlat6.x = u_xlat27 * u_xlat27 + 1.5;
    u_xlat5.x = u_xlat5.x * u_xlat6.x;
    u_xlat5.x = u_xlat16 * u_xlat5.x;
    u_xlat5.x = u_xlat38 / u_xlat5.x;
    u_xlat16_37 = u_xlat27 * u_xlat38;
    u_xlat16_37 = (-u_xlat16_37) * 0.280000001 + 1.0;
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = u_xlat5.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat5.xyw = u_xlat5.xyw * _LightColor0.xyz;
    u_xlat6.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat5.xyw = u_xlat5.xyw * u_xlat6.xxx + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat27<0.00499999989);
#else
    u_xlatb6 = u_xlat27<0.00499999989;
#endif
    u_xlat27 = u_xlat27 * 8.29800034;
    u_xlat16_2.x = (u_xlatb6) ? 0.0 : u_xlat27;
    u_xlat16_13 = dot((-u_xlat11.xyz), u_xlat1.xyz);
    u_xlat16_13 = u_xlat16_13 + u_xlat16_13;
    u_xlat16_9.xyz = u_xlat1.xyz * (-vec3(u_xlat16_13)) + (-u_xlat11.xyz);
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat11.x) + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_3.xyw = vec3(u_xlat16_13) * u_xlat16_3.xyw + u_xlat16_8.xyz;
    u_xlat11.x = dot(u_xlat16_9.zxy, (-u_xlat16_9.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat11.x<9.99999975e-06);
#else
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
#endif
    u_xlat11.x = (u_xlatb11) ? u_xlat16_9.z : (-u_xlat16_9.z);
    u_xlat6.z = u_xlat11.x * u_xlat16_9.x;
    u_xlat10.x = u_xlat11.x * u_xlat16_9.z;
    u_xlat6.xy = (-u_xlat16_9.xy) * u_xlat16_9.yz;
    u_xlat10.yz = (-u_xlat16_9.xy) * u_xlat16_9.xy;
    u_xlat11.xyz = u_xlat6.xyz + (-u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat27);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat11.xyz * u_xlat0.xxx + u_xlat16_9.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_0.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = vec3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_37);
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyw + u_xlat5.xyw;
    u_xlat16_2.x = roundEven(u_xlat16_35);
    u_xlat16_13 = u_xlat16_35 * 2.0 + -1.0;
    u_xlat16_2.xzw = (-u_xlat16_4.xyz) * u_xlat16_25.xxx + u_xlat16_2.xxx;
    u_xlat16_2.xyz = abs(vec3(u_xlat16_13)) * u_xlat16_2.xzw + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
bool u_xlatb6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
float u_xlat16;
mediump vec2 u_xlat16_25;
float u_xlat27;
float u_xlat33;
mediump float u_xlat16_35;
mediump float u_xlat16_37;
float u_xlat38;
void main()
{
    u_xlat16_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_2.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_2.x);
    u_xlat16_3 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_5.xyz = exp2(u_xlat16_5.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_35 = u_xlat16_5.z + -1.0;
    u_xlat16_3.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_35 = _Occlusion * u_xlat16_35 + 1.0;
    u_xlat16_35 = max(u_xlat16_35, _MinMSA.z);
    u_xlat16_2.xyz = vec3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat16_25.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_25.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz + _AddColor.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_25.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_25.xxx * u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat6.xyz = u_xlat5.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat11.xyz = u_xlat11.xxx * u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat6.xyz;
    u_xlat38 = dot(u_xlat1.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat16 = u_xlat38 * u_xlat38;
    u_xlat27 = (-u_xlat16_3.y) + 1.0;
    u_xlat16_3.x = (-u_xlat16_25.x) + u_xlat16_3.y;
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyw = (-u_xlat16_8.xyz) + u_xlat16_3.xxx;
    u_xlat38 = u_xlat27 * u_xlat27;
    u_xlat6.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat16 = u_xlat16 * u_xlat6.x + 1.00001001;
    u_xlat6.x = u_xlat27 * u_xlat27 + 1.5;
    u_xlat5.x = u_xlat5.x * u_xlat6.x;
    u_xlat5.x = u_xlat16 * u_xlat5.x;
    u_xlat5.x = u_xlat38 / u_xlat5.x;
    u_xlat16_37 = u_xlat27 * u_xlat38;
    u_xlat16_37 = (-u_xlat16_37) * 0.280000001 + 1.0;
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = u_xlat5.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat5.xyw = u_xlat5.xyw * _LightColor0.xyz;
    u_xlat6.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat5.xyw = u_xlat5.xyw * u_xlat6.xxx + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat27<0.00499999989);
#else
    u_xlatb6 = u_xlat27<0.00499999989;
#endif
    u_xlat27 = u_xlat27 * 8.29800034;
    u_xlat16_2.x = (u_xlatb6) ? 0.0 : u_xlat27;
    u_xlat16_13 = dot((-u_xlat11.xyz), u_xlat1.xyz);
    u_xlat16_13 = u_xlat16_13 + u_xlat16_13;
    u_xlat16_9.xyz = u_xlat1.xyz * (-vec3(u_xlat16_13)) + (-u_xlat11.xyz);
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat11.x) + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_3.xyw = vec3(u_xlat16_13) * u_xlat16_3.xyw + u_xlat16_8.xyz;
    u_xlat11.x = dot(u_xlat16_9.zxy, (-u_xlat16_9.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat11.x<9.99999975e-06);
#else
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
#endif
    u_xlat11.x = (u_xlatb11) ? u_xlat16_9.z : (-u_xlat16_9.z);
    u_xlat6.z = u_xlat11.x * u_xlat16_9.x;
    u_xlat10.x = u_xlat11.x * u_xlat16_9.z;
    u_xlat6.xy = (-u_xlat16_9.xy) * u_xlat16_9.yz;
    u_xlat10.yz = (-u_xlat16_9.xy) * u_xlat16_9.xy;
    u_xlat11.xyz = u_xlat6.xyz + (-u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat27);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat11.xyz * u_xlat0.xxx + u_xlat16_9.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_0.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = vec3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_37);
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyw + u_xlat5.xyw;
    u_xlat16_2.x = roundEven(u_xlat16_35);
    u_xlat16_13 = u_xlat16_35 * 2.0 + -1.0;
    u_xlat16_2.xzw = (-u_xlat16_4.xyz) * u_xlat16_25.xxx + u_xlat16_2.xxx;
    u_xlat16_2.xyz = abs(vec3(u_xlat16_13)) * u_xlat16_2.xzw + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_11;
mediump float u_xlat16_13;
mediump float u_xlat16_24;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
bool u_xlatb34;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat33 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * _NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat3.xyz = vec3(u_xlat34) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat3.xyz * (-u_xlat16_2.xxx) + (-u_xlat0.xyz);
    u_xlat34 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat34<9.99999975e-06);
#else
    u_xlatb34 = u_xlat34<9.99999975e-06;
#endif
    u_xlat34 = (u_xlatb34) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat34 * u_xlat16_2.x;
    u_xlat5.x = u_xlat34 * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat4.xyz = vec3(u_xlat34) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33) + u_xlat16_2.xyz;
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_24 = u_xlat16_5.z + -1.0;
    u_xlat16_24 = _Occlusion * u_xlat16_24 + 1.0;
    u_xlat16_24 = max(u_xlat16_24, _MinMSA.z);
    u_xlat5.z = (-u_xlat16_2.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat5.z<0.00499999989);
#else
    u_xlatb33 = u_xlat5.z<0.00499999989;
#endif
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_35 = (u_xlatb33) ? 0.0 : u_xlat34;
    u_xlat16_4 = texture(unity_SpecCube0, u_xlat4.xyz, u_xlat16_35);
    u_xlat16_35 = u_xlat16_4.w + -1.0;
    u_xlat16_35 = unity_SpecCube0_HDR.w * u_xlat16_35 + 1.0;
    u_xlat16_35 = u_xlat16_35 * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * vec3(u_xlat16_35);
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_6.xyz;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xyz = texture(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * _SphereMapScale.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + _AddColor.xyz;
    u_xlat16_1.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_2.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_13 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_13 = u_xlat16_13 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_13);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat33)) + u_xlat0.xyz;
    u_xlat33 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_13 = (-u_xlat1.x) + 1.0;
    u_xlat16_11 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_11 = u_xlat16_13 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_13 * u_xlat16_11;
    u_xlat16_9.xyz = vec3(u_xlat16_11) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat16_1.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = vec3(u_xlat16_24) * u_xlat16_9.xyz;
    u_xlat16_10.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_9.xyz * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_13 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_13) * _LightColor0.xyz;
    u_xlat16_9.xyz = vec3(u_xlat33) * u_xlat16_9.xyz;
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_9.xyz + u_xlat16_6.xyz;
    u_xlat16_13 = roundEven(u_xlat16_24);
    u_xlat16_24 = u_xlat16_24 * 2.0 + -1.0;
    u_xlat16_2.xyw = (-u_xlat16_7.xyz) * u_xlat16_2.xxx + vec3(u_xlat16_13);
    u_xlat16_2.xyz = abs(vec3(u_xlat16_24)) * u_xlat16_2.xyw + u_xlat16_10.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
vec3 u_xlat12;
float u_xlat22;
float u_xlat30;
mediump float u_xlat16_31;
float u_xlat32;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
float u_xlat36;
bool u_xlatb36;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + _AddColor.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat16_4.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat16_4.xyz);
    u_xlat2.z = dot(vs_TEXCOORD4.xyz, u_xlat16_4.xyz);
    u_xlat16_4.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xy = max(u_xlat16_0.xy, _MinMSA.xy);
    u_xlat16_31 = u_xlat16_0.z + -1.0;
    u_xlat16_31 = _Occlusion * u_xlat16_31 + 1.0;
    u_xlat16_31 = max(u_xlat16_31, _MinMSA.z);
    u_xlat16_4.xyz = u_xlat16_5.xxx * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat2.x = vs_TEXCOORD2.w;
    u_xlat2.y = vs_TEXCOORD3.w;
    u_xlat2.z = vs_TEXCOORD4.w;
    u_xlat6.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat12.xyz = u_xlat6.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat12.xyz;
    u_xlat32 = dot(u_xlat0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat12.x = u_xlat32 * u_xlat32;
    u_xlat22 = (-u_xlat16_5.y) + 1.0;
    u_xlat32 = u_xlat22 * u_xlat22;
    u_xlat36 = u_xlat32 * u_xlat32 + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat36 + 1.00001001;
    u_xlat36 = u_xlat22 * u_xlat22 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat36;
    u_xlat2.x = u_xlat12.x * u_xlat2.x;
    u_xlat2.x = u_xlat32 / u_xlat2.x;
    u_xlat16_33 = u_xlat22 * u_xlat32;
    u_xlat16_33 = (-u_xlat16_33) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat16_34 = (-u_xlat16_5.x) * 0.779083729 + 0.779083729;
    u_xlat16_5.x = (-u_xlat16_34) + u_xlat16_5.y;
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) + u_xlat16_5.xxx;
    u_xlat16_7.xyz = u_xlat16_3.xyz * vec3(u_xlat16_34);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_4.xyz + u_xlat16_7.xyz;
    u_xlat2.xyw = u_xlat16_1.xyz * u_xlat2.xyw;
    u_xlat16_8.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat36) + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat22<0.00499999989);
#else
    u_xlatb36 = u_xlat22<0.00499999989;
#endif
    u_xlat22 = u_xlat22 * 8.29800034;
    u_xlat16_1.x = (u_xlatb36) ? 0.0 : u_xlat22;
    u_xlat16_11 = dot((-u_xlat6.xyz), u_xlat0.xyz);
    u_xlat16_11 = u_xlat16_11 + u_xlat16_11;
    u_xlat16_9.xyz = u_xlat0.xyz * (-vec3(u_xlat16_11)) + (-u_xlat6.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat0.x) + 1.0;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_4.xyz = vec3(u_xlat16_11) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat16_9.zxy, (-u_xlat16_9.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<9.99999975e-06);
#else
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
#endif
    u_xlat0.x = (u_xlatb0) ? u_xlat16_9.z : (-u_xlat16_9.z);
    u_xlat6.z = u_xlat0.x * u_xlat16_9.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_9.z;
    u_xlat6.xy = (-u_xlat16_9.xy) * u_xlat16_9.yz;
    u_xlat0.yz = (-u_xlat16_9.xy) * u_xlat16_9.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat6.xyz;
    u_xlat22 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_33);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + u_xlat2.xyw;
    u_xlat16_1.x = roundEven(u_xlat16_31);
    u_xlat16_11 = u_xlat16_31 * 2.0 + -1.0;
    u_xlat16_1.xzw = (-u_xlat16_3.xyz) * vec3(u_xlat16_34) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = abs(vec3(u_xlat16_11)) * u_xlat16_1.xzw + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
vec3 u_xlat12;
float u_xlat22;
float u_xlat30;
mediump float u_xlat16_31;
float u_xlat32;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
float u_xlat36;
bool u_xlatb36;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + _AddColor.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat16_4.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat16_4.xyz);
    u_xlat2.z = dot(vs_TEXCOORD4.xyz, u_xlat16_4.xyz);
    u_xlat16_4.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xy = max(u_xlat16_0.xy, _MinMSA.xy);
    u_xlat16_31 = u_xlat16_0.z + -1.0;
    u_xlat16_31 = _Occlusion * u_xlat16_31 + 1.0;
    u_xlat16_31 = max(u_xlat16_31, _MinMSA.z);
    u_xlat16_4.xyz = u_xlat16_5.xxx * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat2.x = vs_TEXCOORD2.w;
    u_xlat2.y = vs_TEXCOORD3.w;
    u_xlat2.z = vs_TEXCOORD4.w;
    u_xlat6.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat12.xyz = u_xlat6.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat12.xyz;
    u_xlat32 = dot(u_xlat0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat12.x = u_xlat32 * u_xlat32;
    u_xlat22 = (-u_xlat16_5.y) + 1.0;
    u_xlat32 = u_xlat22 * u_xlat22;
    u_xlat36 = u_xlat32 * u_xlat32 + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat36 + 1.00001001;
    u_xlat36 = u_xlat22 * u_xlat22 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat36;
    u_xlat2.x = u_xlat12.x * u_xlat2.x;
    u_xlat2.x = u_xlat32 / u_xlat2.x;
    u_xlat16_33 = u_xlat22 * u_xlat32;
    u_xlat16_33 = (-u_xlat16_33) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat16_34 = (-u_xlat16_5.x) * 0.779083729 + 0.779083729;
    u_xlat16_5.x = (-u_xlat16_34) + u_xlat16_5.y;
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) + u_xlat16_5.xxx;
    u_xlat16_7.xyz = u_xlat16_3.xyz * vec3(u_xlat16_34);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_4.xyz + u_xlat16_7.xyz;
    u_xlat2.xyw = u_xlat16_1.xyz * u_xlat2.xyw;
    u_xlat16_8.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat36) + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat22<0.00499999989);
#else
    u_xlatb36 = u_xlat22<0.00499999989;
#endif
    u_xlat22 = u_xlat22 * 8.29800034;
    u_xlat16_1.x = (u_xlatb36) ? 0.0 : u_xlat22;
    u_xlat16_11 = dot((-u_xlat6.xyz), u_xlat0.xyz);
    u_xlat16_11 = u_xlat16_11 + u_xlat16_11;
    u_xlat16_9.xyz = u_xlat0.xyz * (-vec3(u_xlat16_11)) + (-u_xlat6.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat0.x) + 1.0;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_4.xyz = vec3(u_xlat16_11) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat16_9.zxy, (-u_xlat16_9.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<9.99999975e-06);
#else
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
#endif
    u_xlat0.x = (u_xlatb0) ? u_xlat16_9.z : (-u_xlat16_9.z);
    u_xlat6.z = u_xlat0.x * u_xlat16_9.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_9.z;
    u_xlat6.xy = (-u_xlat16_9.xy) * u_xlat16_9.yz;
    u_xlat0.yz = (-u_xlat16_9.xy) * u_xlat16_9.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat6.xyz;
    u_xlat22 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_33);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + u_xlat2.xyw;
    u_xlat16_1.x = roundEven(u_xlat16_31);
    u_xlat16_11 = u_xlat16_31 * 2.0 + -1.0;
    u_xlat16_1.xzw = (-u_xlat16_3.xyz) * vec3(u_xlat16_34) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = abs(vec3(u_xlat16_11)) * u_xlat16_1.xzw + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
mediump float u_xlat16_14;
mediump float u_xlat16_25;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
bool u_xlatb34;
mediump float u_xlat16_36;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat33 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * _NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat2.xyz = vec3(u_xlat34) * u_xlat1.xyz;
    u_xlat16_3.x = dot((-u_xlat0.xyz), u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat2.xyz * (-u_xlat16_3.xxx) + (-u_xlat0.xyz);
    u_xlat34 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat34<9.99999975e-06);
#else
    u_xlatb34 = u_xlat34<9.99999975e-06;
#endif
    u_xlat34 = (u_xlatb34) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat4.z = u_xlat34 * u_xlat16_3.x;
    u_xlat5.x = u_xlat34 * u_xlat16_3.z;
    u_xlat4.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat5.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat4.xyz = vec3(u_xlat34) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33) + u_xlat16_3.xyz;
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_3.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_25 = u_xlat16_5.z + -1.0;
    u_xlat16_25 = _Occlusion * u_xlat16_25 + 1.0;
    u_xlat16_25 = max(u_xlat16_25, _MinMSA.z);
    u_xlat5.z = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat5.z<0.00499999989);
#else
    u_xlatb33 = u_xlat5.z<0.00499999989;
#endif
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_36 = (u_xlatb33) ? 0.0 : u_xlat34;
    u_xlat16_4 = texture(unity_SpecCube0, u_xlat4.xyz, u_xlat16_36);
    u_xlat16_36 = u_xlat16_4.w + -1.0;
    u_xlat16_36 = unity_SpecCube0_HDR.w * u_xlat16_36 + 1.0;
    u_xlat16_36 = u_xlat16_36 * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * vec3(u_xlat16_36);
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xyz = texture(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * _SphereMapScale.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + _AddColor.xyz;
    u_xlat16_1.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_14 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_14 = u_xlat16_14 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_14);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat1.x = u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat33)) + u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_14 = (-u_xlat1.x) + 1.0;
    u_xlat16_11 = u_xlat16_14 * u_xlat16_14;
    u_xlat16_11 = u_xlat16_14 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_14 * u_xlat16_11;
    u_xlat16_9.xyz = vec3(u_xlat16_11) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat16_14 = u_xlat2.y * u_xlat2.y;
    u_xlat16_14 = u_xlat2.x * u_xlat2.x + (-u_xlat16_14);
    u_xlat16_1 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_14) + u_xlat16_9.xyz;
    u_xlat11 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
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
    u_xlat16_5.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = vec3(u_xlat16_25) * u_xlat16_9.xyz;
    u_xlat16_10.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_9.xyz * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_14 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_14) * _LightColor0.xyz;
    u_xlat16_9.xyz = vec3(u_xlat11) * u_xlat16_9.xyz;
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_9.xyz + u_xlat16_6.xyz;
    u_xlat16_14 = roundEven(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * 2.0 + -1.0;
    u_xlat16_3.xyw = (-u_xlat16_7.xyz) * u_xlat16_3.xxx + vec3(u_xlat16_14);
    u_xlat16_3.xyz = abs(vec3(u_xlat16_25)) * u_xlat16_3.xyw + u_xlat16_10.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat16_6.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
bool u_xlatb6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
float u_xlat16;
mediump vec2 u_xlat16_25;
float u_xlat27;
float u_xlat33;
mediump float u_xlat16_35;
mediump float u_xlat16_36;
mediump float u_xlat16_37;
float u_xlat38;
void main()
{
    u_xlat16_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_2.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_2.x);
    u_xlat16_3 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_5.xyz = exp2(u_xlat16_5.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_35 = u_xlat16_5.z + -1.0;
    u_xlat16_3.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_35 = _Occlusion * u_xlat16_35 + 1.0;
    u_xlat16_35 = max(u_xlat16_35, _MinMSA.z);
    u_xlat16_2.xyz = vec3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat16_25.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_25.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz + _AddColor.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_25.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_25.xxx * u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_36 = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_36 = min(max(u_xlat16_36, 0.0), 1.0);
#else
    u_xlat16_36 = clamp(u_xlat16_36, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = vec3(u_xlat16_36) * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_9.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat6.xyz = u_xlat5.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat11.xyz = u_xlat11.xxx * u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat6.xyz;
    u_xlat38 = dot(u_xlat1.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat16 = u_xlat38 * u_xlat38;
    u_xlat27 = (-u_xlat16_3.y) + 1.0;
    u_xlat16_3.x = (-u_xlat16_25.x) + u_xlat16_3.y;
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyw = (-u_xlat16_9.xyz) + u_xlat16_3.xxx;
    u_xlat38 = u_xlat27 * u_xlat27;
    u_xlat6.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat16 = u_xlat16 * u_xlat6.x + 1.00001001;
    u_xlat6.x = u_xlat27 * u_xlat27 + 1.5;
    u_xlat5.x = u_xlat5.x * u_xlat6.x;
    u_xlat5.x = u_xlat16 * u_xlat5.x;
    u_xlat5.x = u_xlat38 / u_xlat5.x;
    u_xlat16_37 = u_xlat27 * u_xlat38;
    u_xlat16_37 = (-u_xlat16_37) * 0.280000001 + 1.0;
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = u_xlat5.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat5.xyw = u_xlat16_8.xyz * u_xlat5.xyw;
    u_xlat6.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat5.xyw = u_xlat5.xyw * u_xlat6.xxx + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat27<0.00499999989);
#else
    u_xlatb6 = u_xlat27<0.00499999989;
#endif
    u_xlat27 = u_xlat27 * 8.29800034;
    u_xlat16_2.x = (u_xlatb6) ? 0.0 : u_xlat27;
    u_xlat16_13 = dot((-u_xlat11.xyz), u_xlat1.xyz);
    u_xlat16_13 = u_xlat16_13 + u_xlat16_13;
    u_xlat16_8.xyz = u_xlat1.xyz * (-vec3(u_xlat16_13)) + (-u_xlat11.xyz);
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat11.x) + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_3.xyw = vec3(u_xlat16_13) * u_xlat16_3.xyw + u_xlat16_9.xyz;
    u_xlat11.x = dot(u_xlat16_8.zxy, (-u_xlat16_8.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat11.x<9.99999975e-06);
#else
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
#endif
    u_xlat11.x = (u_xlatb11) ? u_xlat16_8.z : (-u_xlat16_8.z);
    u_xlat6.z = u_xlat11.x * u_xlat16_8.x;
    u_xlat10.x = u_xlat11.x * u_xlat16_8.z;
    u_xlat6.xy = (-u_xlat16_8.xy) * u_xlat16_8.yz;
    u_xlat10.yz = (-u_xlat16_8.xy) * u_xlat16_8.xy;
    u_xlat11.xyz = u_xlat6.xyz + (-u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat27);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat11.xyz * u_xlat0.xxx + u_xlat16_8.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_0.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = vec3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_37);
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyw + u_xlat5.xyw;
    u_xlat16_2.x = roundEven(u_xlat16_35);
    u_xlat16_13 = u_xlat16_35 * 2.0 + -1.0;
    u_xlat16_2.xzw = (-u_xlat16_4.xyz) * u_xlat16_25.xxx + u_xlat16_2.xxx;
    u_xlat16_2.xyz = abs(vec3(u_xlat16_13)) * u_xlat16_2.xzw + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
bool u_xlatb6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
float u_xlat16;
mediump vec2 u_xlat16_25;
float u_xlat27;
float u_xlat33;
mediump float u_xlat16_35;
mediump float u_xlat16_36;
mediump float u_xlat16_37;
float u_xlat38;
void main()
{
    u_xlat16_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_2.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_2.x);
    u_xlat16_3 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_5.xyz = exp2(u_xlat16_5.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_35 = u_xlat16_5.z + -1.0;
    u_xlat16_3.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_35 = _Occlusion * u_xlat16_35 + 1.0;
    u_xlat16_35 = max(u_xlat16_35, _MinMSA.z);
    u_xlat16_2.xyz = vec3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat16_25.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_25.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz + _AddColor.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_25.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_25.xxx * u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_36 = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_36 = min(max(u_xlat16_36, 0.0), 1.0);
#else
    u_xlat16_36 = clamp(u_xlat16_36, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = vec3(u_xlat16_36) * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_9.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat6.xyz = u_xlat5.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat11.xyz = u_xlat11.xxx * u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat6.xyz;
    u_xlat38 = dot(u_xlat1.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat16 = u_xlat38 * u_xlat38;
    u_xlat27 = (-u_xlat16_3.y) + 1.0;
    u_xlat16_3.x = (-u_xlat16_25.x) + u_xlat16_3.y;
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyw = (-u_xlat16_9.xyz) + u_xlat16_3.xxx;
    u_xlat38 = u_xlat27 * u_xlat27;
    u_xlat6.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat16 = u_xlat16 * u_xlat6.x + 1.00001001;
    u_xlat6.x = u_xlat27 * u_xlat27 + 1.5;
    u_xlat5.x = u_xlat5.x * u_xlat6.x;
    u_xlat5.x = u_xlat16 * u_xlat5.x;
    u_xlat5.x = u_xlat38 / u_xlat5.x;
    u_xlat16_37 = u_xlat27 * u_xlat38;
    u_xlat16_37 = (-u_xlat16_37) * 0.280000001 + 1.0;
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = u_xlat5.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat5.xyw = u_xlat16_8.xyz * u_xlat5.xyw;
    u_xlat6.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat5.xyw = u_xlat5.xyw * u_xlat6.xxx + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat27<0.00499999989);
#else
    u_xlatb6 = u_xlat27<0.00499999989;
#endif
    u_xlat27 = u_xlat27 * 8.29800034;
    u_xlat16_2.x = (u_xlatb6) ? 0.0 : u_xlat27;
    u_xlat16_13 = dot((-u_xlat11.xyz), u_xlat1.xyz);
    u_xlat16_13 = u_xlat16_13 + u_xlat16_13;
    u_xlat16_8.xyz = u_xlat1.xyz * (-vec3(u_xlat16_13)) + (-u_xlat11.xyz);
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat11.x) + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_3.xyw = vec3(u_xlat16_13) * u_xlat16_3.xyw + u_xlat16_9.xyz;
    u_xlat11.x = dot(u_xlat16_8.zxy, (-u_xlat16_8.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat11.x<9.99999975e-06);
#else
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
#endif
    u_xlat11.x = (u_xlatb11) ? u_xlat16_8.z : (-u_xlat16_8.z);
    u_xlat6.z = u_xlat11.x * u_xlat16_8.x;
    u_xlat10.x = u_xlat11.x * u_xlat16_8.z;
    u_xlat6.xy = (-u_xlat16_8.xy) * u_xlat16_8.yz;
    u_xlat10.yz = (-u_xlat16_8.xy) * u_xlat16_8.xy;
    u_xlat11.xyz = u_xlat6.xyz + (-u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat27);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat11.xyz * u_xlat0.xxx + u_xlat16_8.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_0.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = vec3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_37);
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyw + u_xlat5.xyw;
    u_xlat16_2.x = roundEven(u_xlat16_35);
    u_xlat16_13 = u_xlat16_35 * 2.0 + -1.0;
    u_xlat16_2.xzw = (-u_xlat16_4.xyz) * u_xlat16_25.xxx + u_xlat16_2.xxx;
    u_xlat16_2.xyz = abs(vec3(u_xlat16_13)) * u_xlat16_2.xzw + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp float vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat15, u_xlat16_4);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp float vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_11;
mediump float u_xlat16_13;
mediump float u_xlat16_24;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
bool u_xlatb34;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat33 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * _NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat3.xyz = vec3(u_xlat34) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat3.xyz * (-u_xlat16_2.xxx) + (-u_xlat0.xyz);
    u_xlat34 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat34<9.99999975e-06);
#else
    u_xlatb34 = u_xlat34<9.99999975e-06;
#endif
    u_xlat34 = (u_xlatb34) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat34 * u_xlat16_2.x;
    u_xlat5.x = u_xlat34 * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat4.xyz = vec3(u_xlat34) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33) + u_xlat16_2.xyz;
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_24 = u_xlat16_5.z + -1.0;
    u_xlat16_24 = _Occlusion * u_xlat16_24 + 1.0;
    u_xlat16_24 = max(u_xlat16_24, _MinMSA.z);
    u_xlat5.z = (-u_xlat16_2.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat5.z<0.00499999989);
#else
    u_xlatb33 = u_xlat5.z<0.00499999989;
#endif
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_35 = (u_xlatb33) ? 0.0 : u_xlat34;
    u_xlat16_4 = texture(unity_SpecCube0, u_xlat4.xyz, u_xlat16_35);
    u_xlat16_35 = u_xlat16_4.w + -1.0;
    u_xlat16_35 = unity_SpecCube0_HDR.w * u_xlat16_35 + 1.0;
    u_xlat16_35 = u_xlat16_35 * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * vec3(u_xlat16_35);
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_6.xyz;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xyz = texture(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * _SphereMapScale.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + _AddColor.xyz;
    u_xlat16_1.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_2.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_13 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_13 = u_xlat16_13 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_13);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat33)) + u_xlat0.xyz;
    u_xlat33 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = vec3(u_xlat33) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_13 = (-u_xlat1.x) + 1.0;
    u_xlat16_11 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_11 = u_xlat16_13 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_13 * u_xlat16_11;
    u_xlat16_9.xyz = vec3(u_xlat16_11) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat16_9.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat16_13 = roundEven(u_xlat16_24);
    u_xlat16_24 = u_xlat16_24 * 2.0 + -1.0;
    u_xlat16_2.xyw = (-u_xlat16_7.xyz) * u_xlat16_2.xxx + vec3(u_xlat16_13);
    u_xlat16_2.xyz = abs(vec3(u_xlat16_24)) * u_xlat16_2.xyw + u_xlat16_9.xyz;
    u_xlat16_0.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp float vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat15, u_xlat16_4);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp float vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_13;
float u_xlat20;
mediump float u_xlat16_23;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
mediump float u_xlat16_33;
mediump float u_xlat16_36;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat30 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD4.xyz, u_xlat16_3.xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot((-u_xlat11.xyz), u_xlat4.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat4.xyz * (-u_xlat16_3.xxx) + (-u_xlat11.xyz);
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_33 = (-u_xlat1.x) + 1.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat1.x = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat5.z = u_xlat1.x * u_xlat16_3.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_3.z;
    u_xlat5.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat1.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat5.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat1.xyz = vec3(u_xlat31) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat30) + u_xlat16_3.xyz;
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_3.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_23 = u_xlat16_5.z + -1.0;
    u_xlat16_23 = _Occlusion * u_xlat16_23 + 1.0;
    u_xlat16_23 = max(u_xlat16_23, _MinMSA.z);
    u_xlat30 = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat30<0.00499999989);
#else
    u_xlatb31 = u_xlat30<0.00499999989;
#endif
    u_xlat32 = u_xlat30 * 8.29800034;
    u_xlat16_6.x = (u_xlatb31) ? 0.0 : u_xlat32;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat1.xyz, u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_1.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = vec3(u_xlat16_23) * u_xlat16_6.xyz;
    u_xlat1.x = u_xlat30 * u_xlat30;
    u_xlat16_36 = u_xlat30 * u_xlat1.x;
    u_xlat30 = u_xlat30 * u_xlat30 + 1.5;
    u_xlat16_36 = (-u_xlat16_36) * 0.280000001 + 1.0;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_36);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_11.xyz = texture(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_11.xyz * _SphereMapScale.xyz;
    u_xlat16_11.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_11.xyz * u_xlat16_2.xyz + _AddColor.xyz;
    u_xlat16_11.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_13 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_13 = u_xlat16_13 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_13);
    u_xlat16_9.xyz = vec3(u_xlat16_33) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat11.xxx;
    u_xlat11.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat20 = max(u_xlat11.x, 0.319999993);
    u_xlat20 = u_xlat30 * u_xlat20;
    u_xlat30 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat30 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat20;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_9.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat10) + u_xlat16_6.xyz;
    u_xlat16_13 = roundEven(u_xlat16_23);
    u_xlat16_23 = u_xlat16_23 * 2.0 + -1.0;
    u_xlat16_3.xyw = (-u_xlat16_7.xyz) * u_xlat16_3.xxx + vec3(u_xlat16_13);
    u_xlat16_3.xyz = abs(vec3(u_xlat16_23)) * u_xlat16_3.xyw + u_xlat16_9.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp float vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat15, u_xlat16_4);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp float vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
float u_xlat10;
vec3 u_xlat11;
mediump vec3 u_xlat16_11;
mediump float u_xlat16_13;
float u_xlat20;
mediump float u_xlat16_23;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
mediump float u_xlat16_33;
mediump float u_xlat16_36;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat30 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat11.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat2.z = dot(vs_TEXCOORD4.xyz, u_xlat16_3.xyz);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat1.xxx * u_xlat2.xyz;
    u_xlat16_3.x = dot((-u_xlat11.xyz), u_xlat4.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat4.xyz * (-u_xlat16_3.xxx) + (-u_xlat11.xyz);
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_33 = (-u_xlat1.x) + 1.0;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_33 = u_xlat16_33 * u_xlat16_33;
    u_xlat1.x = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<9.99999975e-06);
#else
    u_xlatb1 = u_xlat1.x<9.99999975e-06;
#endif
    u_xlat1.x = (u_xlatb1) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat5.z = u_xlat1.x * u_xlat16_3.x;
    u_xlat1.x = u_xlat1.x * u_xlat16_3.z;
    u_xlat5.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat1.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat1.xyz = (-u_xlat1.xyz) + u_xlat5.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat1.xyz = vec3(u_xlat31) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_NormalDiff);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat30) + u_xlat16_3.xyz;
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_3.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_23 = u_xlat16_5.z + -1.0;
    u_xlat16_23 = _Occlusion * u_xlat16_23 + 1.0;
    u_xlat16_23 = max(u_xlat16_23, _MinMSA.z);
    u_xlat30 = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat30<0.00499999989);
#else
    u_xlatb31 = u_xlat30<0.00499999989;
#endif
    u_xlat32 = u_xlat30 * 8.29800034;
    u_xlat16_6.x = (u_xlatb31) ? 0.0 : u_xlat32;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat1.xyz, u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_1.w + -1.0;
    u_xlat16_6.x = unity_SpecCube0_HDR.w * u_xlat16_6.x + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_6.xxx;
    u_xlat16_6.xyz = vec3(u_xlat16_23) * u_xlat16_6.xyz;
    u_xlat1.x = u_xlat30 * u_xlat30;
    u_xlat16_36 = u_xlat30 * u_xlat1.x;
    u_xlat30 = u_xlat30 * u_xlat30 + 1.5;
    u_xlat16_36 = (-u_xlat16_36) * 0.280000001 + 1.0;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_36);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_11.xyz = texture(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_11.xyz * _SphereMapScale.xyz;
    u_xlat16_11.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_11.xyz * u_xlat16_2.xyz + _AddColor.xyz;
    u_xlat16_11.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_11.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_13 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_13 = u_xlat16_13 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_13);
    u_xlat16_9.xyz = vec3(u_xlat16_33) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat11.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat11.x = max(u_xlat11.x, 0.00100000005);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat11.xxx;
    u_xlat11.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat20 = max(u_xlat11.x, 0.319999993);
    u_xlat20 = u_xlat30 * u_xlat20;
    u_xlat30 = u_xlat1.x * u_xlat1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat30 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat20;
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_9.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat10) + u_xlat16_6.xyz;
    u_xlat16_13 = roundEven(u_xlat16_23);
    u_xlat16_23 = u_xlat16_23 * 2.0 + -1.0;
    u_xlat16_3.xyw = (-u_xlat16_7.xyz) * u_xlat16_3.xxx + vec3(u_xlat16_13);
    u_xlat16_3.xyz = abs(vec3(u_xlat16_23)) * u_xlat16_3.xyw + u_xlat16_9.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD5;
out highp float vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat18 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_1 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_1);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat18, u_xlat16_4);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD5;
in highp float vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
mediump float u_xlat16_15;
mediump float u_xlat16_27;
float u_xlat36;
bool u_xlatb36;
float u_xlat37;
bool u_xlatb37;
mediump float u_xlat16_39;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat36 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat36 = sin(u_xlat36);
    u_xlat36 = u_xlat36 * _NormalRand.w;
    u_xlat36 = fract(u_xlat36);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat37 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat2.xyz = vec3(u_xlat37) * u_xlat1.xyz;
    u_xlat16_3.x = dot((-u_xlat0.xyz), u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat2.xyz * (-u_xlat16_3.xxx) + (-u_xlat0.xyz);
    u_xlat37 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb37 = !!(u_xlat37<9.99999975e-06);
#else
    u_xlatb37 = u_xlat37<9.99999975e-06;
#endif
    u_xlat37 = (u_xlatb37) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat4.z = u_xlat37 * u_xlat16_3.x;
    u_xlat5.x = u_xlat37 * u_xlat16_3.z;
    u_xlat4.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat5.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat4.xyz = vec3(u_xlat37) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat36) + u_xlat16_3.xyz;
    u_xlat36 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat4.xyz = vec3(u_xlat36) * u_xlat4.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_3.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_27 = u_xlat16_5.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_27 = max(u_xlat16_27, _MinMSA.z);
    u_xlat5.z = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat5.z<0.00499999989);
#else
    u_xlatb36 = u_xlat5.z<0.00499999989;
#endif
    u_xlat37 = u_xlat5.z * 8.29800034;
    u_xlat16_39 = (u_xlatb36) ? 0.0 : u_xlat37;
    u_xlat16_4 = texture(unity_SpecCube0, u_xlat4.xyz, u_xlat16_39);
    u_xlat16_39 = u_xlat16_4.w + -1.0;
    u_xlat16_39 = unity_SpecCube0_HDR.w * u_xlat16_39 + 1.0;
    u_xlat16_39 = u_xlat16_39 * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * vec3(u_xlat16_39);
    u_xlat16_6.xyz = vec3(u_xlat16_27) * u_xlat16_6.xyz;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xyz = texture(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * _SphereMapScale.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + _AddColor.xyz;
    u_xlat16_1.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_15 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_15 = u_xlat16_15 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_15);
    u_xlat36 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat1.x = u_xlat36;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat36 = u_xlat36 + u_xlat36;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat36)) + u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat16_15 = (-u_xlat1.x) + 1.0;
    u_xlat16_12 = u_xlat16_15 * u_xlat16_15;
    u_xlat16_12 = u_xlat16_15 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_15 * u_xlat16_12;
    u_xlat16_9.xyz = vec3(u_xlat16_12) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = u_xlat12.xxx * _LightColor0.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_10.xyz = u_xlat16_10.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_10.xyz = max(u_xlat16_10.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.yzw = log2(u_xlat16_10.xyz);
    u_xlat0 = u_xlat0 * vec4(16.0, 0.416666657, 0.416666657, 0.416666657);
    u_xlat12.xyz = exp2(u_xlat0.yzw);
    u_xlat12.xyz = u_xlat12.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat12.xyz = max(u_xlat12.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = vec3(u_xlat16_27) * u_xlat12.xyz;
    u_xlat16_11.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_10.xyz * u_xlat16_11.xyz + u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_11.xyz;
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_9.xyz + u_xlat16_6.xyz;
    u_xlat16_15 = roundEven(u_xlat16_27);
    u_xlat16_27 = u_xlat16_27 * 2.0 + -1.0;
    u_xlat16_3.xyw = (-u_xlat16_7.xyz) * u_xlat16_3.xxx + vec3(u_xlat16_15);
    u_xlat16_3.xyz = abs(vec3(u_xlat16_27)) * u_xlat16_3.xyw + u_xlat16_11.xyz;
    u_xlat16_0.xyz = u_xlat16_6.xyz * u_xlat16_3.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD5;
out highp float vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat18 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_1 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_1);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat18, u_xlat16_4);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD5;
in highp float vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
bool u_xlatb11;
mediump vec3 u_xlat16_13;
float u_xlat14;
mediump float u_xlat16_24;
float u_xlat25;
float u_xlat33;
mediump float u_xlat16_35;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat16_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.x = u_xlat16_4.z + -1.0;
    u_xlat16_13.xy = max(u_xlat16_4.xy, _MinMSA.xy);
    u_xlat16_2.x = _Occlusion * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, _MinMSA.z);
    u_xlat16_5.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + _AddColor.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_35 = (-u_xlat16_13.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_35) * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_13.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat4.xyz = u_xlat3.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat36 = dot(u_xlat1.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat14 = u_xlat36 * u_xlat36;
    u_xlat25 = (-u_xlat16_13.y) + 1.0;
    u_xlat16_13.x = (-u_xlat16_35) + u_xlat16_13.y;
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13.x = min(max(u_xlat16_13.x, 0.0), 1.0);
#else
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + u_xlat16_13.xxx;
    u_xlat36 = u_xlat25 * u_xlat25;
    u_xlat4.x = u_xlat36 * u_xlat36 + -1.0;
    u_xlat14 = u_xlat14 * u_xlat4.x + 1.00001001;
    u_xlat4.x = u_xlat25 * u_xlat25 + 1.5;
    u_xlat3.x = u_xlat3.x * u_xlat4.x;
    u_xlat3.x = u_xlat14 * u_xlat3.x;
    u_xlat3.x = u_xlat36 / u_xlat3.x;
    u_xlat16_13.x = u_xlat25 * u_xlat36;
    u_xlat16_13.x = (-u_xlat16_13.x) * 0.280000001 + 1.0;
    u_xlat3.x = u_xlat3.x + -9.99999975e-05;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = min(u_xlat3.x, 100.0);
    u_xlat3.xyw = u_xlat3.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat3.xyw = u_xlat3.xyw * _LightColor0.xyz;
    u_xlat4.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat3.xyw = u_xlat3.xyw * u_xlat4.xxx + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat25<0.00499999989);
#else
    u_xlatb4 = u_xlat25<0.00499999989;
#endif
    u_xlat25 = u_xlat25 * 8.29800034;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat25;
    u_xlat16_5.x = dot((-u_xlat11.xyz), u_xlat1.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat1.xyz * (-u_xlat16_5.xxx) + (-u_xlat11.xyz);
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat11.x) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat11.x = dot(u_xlat16_5.zxy, (-u_xlat16_5.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat11.x<9.99999975e-06);
#else
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
#endif
    u_xlat11.x = (u_xlatb11) ? u_xlat16_5.z : (-u_xlat16_5.z);
    u_xlat4.z = u_xlat11.x * u_xlat16_5.x;
    u_xlat10.x = u_xlat11.x * u_xlat16_5.z;
    u_xlat4.xy = (-u_xlat16_5.xy) * u_xlat16_5.yz;
    u_xlat10.yz = (-u_xlat16_5.xy) * u_xlat16_5.xy;
    u_xlat11.xyz = u_xlat4.xyz + (-u_xlat10.xyz);
    u_xlat25 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat25);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat11.xyz * u_xlat0.xxx + u_xlat16_5.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_24);
    u_xlat16_24 = u_xlat16_0.w + -1.0;
    u_xlat16_24 = unity_SpecCube0_HDR.w * u_xlat16_24 + 1.0;
    u_xlat16_24 = u_xlat16_24 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_0.xyz * vec3(u_xlat16_24);
    u_xlat16_5.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_13.xxx * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat3.xyw;
    u_xlat16_13.x = roundEven(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * 2.0 + -1.0;
    u_xlat16_13.xyz = (-u_xlat16_6.xyz) * vec3(u_xlat16_35) + u_xlat16_13.xxx;
    u_xlat16_2.xyz = abs(u_xlat16_2.xxx) * u_xlat16_13.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD5;
out highp float vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat18 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_1 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_1);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat18, u_xlat16_4);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD5;
in highp float vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
bool u_xlatb4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
bool u_xlatb11;
mediump vec3 u_xlat16_13;
float u_xlat14;
mediump float u_xlat16_24;
float u_xlat25;
float u_xlat33;
mediump float u_xlat16_35;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat16_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.x = u_xlat16_4.z + -1.0;
    u_xlat16_13.xy = max(u_xlat16_4.xy, _MinMSA.xy);
    u_xlat16_2.x = _Occlusion * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = max(u_xlat16_2.x, _MinMSA.z);
    u_xlat16_5.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat3.xyz, u_xlat0.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + _AddColor.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_35 = (-u_xlat16_13.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_35) * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_13.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat3.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat4.xyz = u_xlat3.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat11.xyz = u_xlat11.xxx * u_xlat3.xyz;
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat3.x = max(u_xlat3.x, 0.00100000005);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat36 = dot(u_xlat1.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat3.x = dot(_WorldSpaceLightPos0.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat3.x = max(u_xlat3.x, 0.319999993);
    u_xlat14 = u_xlat36 * u_xlat36;
    u_xlat25 = (-u_xlat16_13.y) + 1.0;
    u_xlat16_13.x = (-u_xlat16_35) + u_xlat16_13.y;
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13.x = min(max(u_xlat16_13.x, 0.0), 1.0);
#else
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + u_xlat16_13.xxx;
    u_xlat36 = u_xlat25 * u_xlat25;
    u_xlat4.x = u_xlat36 * u_xlat36 + -1.0;
    u_xlat14 = u_xlat14 * u_xlat4.x + 1.00001001;
    u_xlat4.x = u_xlat25 * u_xlat25 + 1.5;
    u_xlat3.x = u_xlat3.x * u_xlat4.x;
    u_xlat3.x = u_xlat14 * u_xlat3.x;
    u_xlat3.x = u_xlat36 / u_xlat3.x;
    u_xlat16_13.x = u_xlat25 * u_xlat36;
    u_xlat16_13.x = (-u_xlat16_13.x) * 0.280000001 + 1.0;
    u_xlat3.x = u_xlat3.x + -9.99999975e-05;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = min(u_xlat3.x, 100.0);
    u_xlat3.xyw = u_xlat3.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat3.xyw = u_xlat3.xyw * _LightColor0.xyz;
    u_xlat4.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat3.xyw = u_xlat3.xyw * u_xlat4.xxx + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat25<0.00499999989);
#else
    u_xlatb4 = u_xlat25<0.00499999989;
#endif
    u_xlat25 = u_xlat25 * 8.29800034;
    u_xlat16_24 = (u_xlatb4) ? 0.0 : u_xlat25;
    u_xlat16_5.x = dot((-u_xlat11.xyz), u_xlat1.xyz);
    u_xlat16_5.x = u_xlat16_5.x + u_xlat16_5.x;
    u_xlat16_5.xyz = u_xlat1.xyz * (-u_xlat16_5.xxx) + (-u_xlat11.xyz);
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat11.x) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat11.x = dot(u_xlat16_5.zxy, (-u_xlat16_5.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat11.x<9.99999975e-06);
#else
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
#endif
    u_xlat11.x = (u_xlatb11) ? u_xlat16_5.z : (-u_xlat16_5.z);
    u_xlat4.z = u_xlat11.x * u_xlat16_5.x;
    u_xlat10.x = u_xlat11.x * u_xlat16_5.z;
    u_xlat4.xy = (-u_xlat16_5.xy) * u_xlat16_5.yz;
    u_xlat10.yz = (-u_xlat16_5.xy) * u_xlat16_5.xy;
    u_xlat11.xyz = u_xlat4.xyz + (-u_xlat10.xyz);
    u_xlat25 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat25);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat11.xyz * u_xlat0.xxx + u_xlat16_5.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_24);
    u_xlat16_24 = u_xlat16_0.w + -1.0;
    u_xlat16_24 = unity_SpecCube0_HDR.w * u_xlat16_24 + 1.0;
    u_xlat16_24 = u_xlat16_24 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_0.xyz * vec3(u_xlat16_24);
    u_xlat16_5.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_13.xxx * u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz + u_xlat3.xyw;
    u_xlat16_13.x = roundEven(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * 2.0 + -1.0;
    u_xlat16_13.xyz = (-u_xlat16_6.xyz) * vec3(u_xlat16_35) + u_xlat16_13.xxx;
    u_xlat16_2.xyz = abs(u_xlat16_2.xxx) * u_xlat16_13.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD5;
out highp float vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat18 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_1 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_1);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat18, u_xlat16_4);
    vs_TEXCOORD7.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD5;
in highp float vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
mediump float u_xlat16_14;
mediump float u_xlat16_25;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
bool u_xlatb34;
mediump float u_xlat16_36;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat33 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * _NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat2.xyz = vec3(u_xlat34) * u_xlat1.xyz;
    u_xlat16_3.x = dot((-u_xlat0.xyz), u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat2.xyz * (-u_xlat16_3.xxx) + (-u_xlat0.xyz);
    u_xlat34 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat34<9.99999975e-06);
#else
    u_xlatb34 = u_xlat34<9.99999975e-06;
#endif
    u_xlat34 = (u_xlatb34) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat4.z = u_xlat34 * u_xlat16_3.x;
    u_xlat5.x = u_xlat34 * u_xlat16_3.z;
    u_xlat4.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat5.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat4.xyz = vec3(u_xlat34) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33) + u_xlat16_3.xyz;
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_3.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_25 = u_xlat16_5.z + -1.0;
    u_xlat16_25 = _Occlusion * u_xlat16_25 + 1.0;
    u_xlat16_25 = max(u_xlat16_25, _MinMSA.z);
    u_xlat5.z = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat5.z<0.00499999989);
#else
    u_xlatb33 = u_xlat5.z<0.00499999989;
#endif
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_36 = (u_xlatb33) ? 0.0 : u_xlat34;
    u_xlat16_4 = texture(unity_SpecCube0, u_xlat4.xyz, u_xlat16_36);
    u_xlat16_36 = u_xlat16_4.w + -1.0;
    u_xlat16_36 = unity_SpecCube0_HDR.w * u_xlat16_36 + 1.0;
    u_xlat16_36 = u_xlat16_36 * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * vec3(u_xlat16_36);
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xyz = texture(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * _SphereMapScale.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + _AddColor.xyz;
    u_xlat16_1.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_14 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_14 = u_xlat16_14 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_14);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat1.x = u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat33)) + u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_14 = (-u_xlat1.x) + 1.0;
    u_xlat16_11 = u_xlat16_14 * u_xlat16_14;
    u_xlat16_11 = u_xlat16_14 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_14 * u_xlat16_11;
    u_xlat16_9.xyz = vec3(u_xlat16_11) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat11 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    u_xlat16_10.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_9.xyz * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_14 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_14) * _LightColor0.xyz;
    u_xlat16_9.xyz = vec3(u_xlat11) * u_xlat16_9.xyz;
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_9.xyz + u_xlat16_6.xyz;
    u_xlat16_14 = roundEven(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * 2.0 + -1.0;
    u_xlat16_3.xyw = (-u_xlat16_7.xyz) * u_xlat16_3.xxx + vec3(u_xlat16_14);
    u_xlat16_3.xyz = abs(vec3(u_xlat16_25)) * u_xlat16_3.xyw + u_xlat16_10.xyz;
    u_xlat16_0.xyz = u_xlat16_6.xyz * u_xlat16_3.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD5;
out highp float vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat18 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_1 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_1);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat18, u_xlat16_4);
    vs_TEXCOORD7.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD5;
in highp float vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
vec3 u_xlat12;
float u_xlat16;
float u_xlat26;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
float u_xlat36;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + _AddColor.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat16_4.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat16_4.xyz);
    u_xlat2.z = dot(vs_TEXCOORD4.xyz, u_xlat16_4.xyz);
    u_xlat16_4.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xy = max(u_xlat16_0.xy, _MinMSA.xy);
    u_xlat16_31 = u_xlat16_0.z + -1.0;
    u_xlat16_31 = _Occlusion * u_xlat16_31 + 1.0;
    u_xlat16_31 = max(u_xlat16_31, _MinMSA.z);
    u_xlat16_4.xyz = u_xlat16_5.xxx * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_33 = (-u_xlat16_5.x) * 0.779083729 + 0.779083729;
    u_xlat16_5.xzw = vec3(u_xlat16_33) * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat2.x = vs_TEXCOORD2.w;
    u_xlat2.y = vs_TEXCOORD3.w;
    u_xlat2.z = vs_TEXCOORD4.w;
    u_xlat6.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _NormalRand.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat12.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat7.xyz = u_xlat6.xyz * u_xlat12.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat12.xyz = u_xlat12.xxx * u_xlat6.xyz;
    u_xlat6.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat6.x = max(u_xlat6.x, 0.00100000005);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat7.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat6.x = dot(_WorldSpaceLightPos0.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat6.x = max(u_xlat6.x, 0.319999993);
    u_xlat16 = u_xlat36 * u_xlat36;
    u_xlat26 = (-u_xlat16_5.y) + 1.0;
    u_xlat16_34 = (-u_xlat16_33) + u_xlat16_5.y;
    u_xlat16_34 = u_xlat16_34 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_34);
    u_xlat36 = u_xlat26 * u_xlat26;
    u_xlat7.x = u_xlat36 * u_xlat36 + -1.0;
    u_xlat16 = u_xlat16 * u_xlat7.x + 1.00001001;
    u_xlat7.x = u_xlat26 * u_xlat26 + 1.5;
    u_xlat6.x = u_xlat6.x * u_xlat7.x;
    u_xlat6.x = u_xlat16 * u_xlat6.x;
    u_xlat6.x = u_xlat36 / u_xlat6.x;
    u_xlat16_34 = u_xlat26 * u_xlat36;
    u_xlat16_34 = (-u_xlat16_34) * 0.280000001 + 1.0;
    u_xlat6.x = u_xlat6.x + -9.99999975e-05;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat6.x = min(u_xlat6.x, 100.0);
    u_xlat6.xyw = u_xlat6.xxx * u_xlat16_4.xyz + u_xlat16_5.xzw;
    u_xlat6.xyw = u_xlat16_1.xyz * u_xlat6.xyw;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_7.xyz = exp2(u_xlat16_7.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xzw * u_xlat16_1.xyz;
    u_xlat30 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat6.xyw = u_xlat6.xyw * vec3(u_xlat30) + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat26<0.00499999989);
#else
    u_xlatb30 = u_xlat26<0.00499999989;
#endif
    u_xlat26 = u_xlat26 * 8.29800034;
    u_xlat16_1.x = (u_xlatb30) ? 0.0 : u_xlat26;
    u_xlat16_11 = dot((-u_xlat12.xyz), u_xlat0.xyz);
    u_xlat16_11 = u_xlat16_11 + u_xlat16_11;
    u_xlat16_9.xyz = u_xlat0.xyz * (-vec3(u_xlat16_11)) + (-u_xlat12.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat0.x) + 1.0;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_4.xyz = vec3(u_xlat16_11) * u_xlat16_8.xyz + u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat16_9.zxy, (-u_xlat16_9.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<9.99999975e-06);
#else
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
#endif
    u_xlat0.x = (u_xlatb0) ? u_xlat16_9.z : (-u_xlat16_9.z);
    u_xlat7.z = u_xlat0.x * u_xlat16_9.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_9.z;
    u_xlat7.xy = (-u_xlat16_9.xy) * u_xlat16_9.yz;
    u_xlat0.yz = (-u_xlat16_9.xy) * u_xlat16_9.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat7.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_34);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + u_xlat6.xyw;
    u_xlat16_1.x = roundEven(u_xlat16_31);
    u_xlat16_11 = u_xlat16_31 * 2.0 + -1.0;
    u_xlat16_1.xzw = (-u_xlat16_3.xyz) * vec3(u_xlat16_33) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = abs(vec3(u_xlat16_11)) * u_xlat16_1.xzw + u_xlat16_5.xzw;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD5;
out highp float vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat18 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    vs_TEXCOORD2.x = u_xlat1.z;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.z = u_xlat2.x;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_TEXCOORD3.z = u_xlat2.y;
    vs_TEXCOORD4.z = u_xlat2.w;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_4 = u_xlat2.y * u_xlat2.y;
    u_xlat16_4 = u_xlat2.x * u_xlat2.x + (-u_xlat16_4);
    u_xlat16_1 = u_xlat2.ywzx * u_xlat2;
    u_xlat16_5.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_5.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_5.z = dot(unity_SHBb, u_xlat16_1);
    vs_TEXCOORD5.xyz = unity_SHC.xyz * vec3(u_xlat16_4) + u_xlat16_5.xyz;
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat18, u_xlat16_4);
    vs_TEXCOORD7.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD5;
in highp float vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
vec4 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
vec3 u_xlat12;
float u_xlat16;
float u_xlat26;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
float u_xlat36;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + _AddColor.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat16_4.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat16_4.xyz);
    u_xlat2.z = dot(vs_TEXCOORD4.xyz, u_xlat16_4.xyz);
    u_xlat16_4.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xy = max(u_xlat16_0.xy, _MinMSA.xy);
    u_xlat16_31 = u_xlat16_0.z + -1.0;
    u_xlat16_31 = _Occlusion * u_xlat16_31 + 1.0;
    u_xlat16_31 = max(u_xlat16_31, _MinMSA.z);
    u_xlat16_4.xyz = u_xlat16_5.xxx * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_33 = (-u_xlat16_5.x) * 0.779083729 + 0.779083729;
    u_xlat16_5.xzw = vec3(u_xlat16_33) * u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat2.x = vs_TEXCOORD2.w;
    u_xlat2.y = vs_TEXCOORD3.w;
    u_xlat2.z = vs_TEXCOORD4.w;
    u_xlat6.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _NormalRand.w;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat12.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat12.x = inversesqrt(u_xlat12.x);
    u_xlat7.xyz = u_xlat6.xyz * u_xlat12.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat12.xyz = u_xlat12.xxx * u_xlat6.xyz;
    u_xlat6.x = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat6.x = max(u_xlat6.x, 0.00100000005);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat7.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat6.x = dot(_WorldSpaceLightPos0.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat6.x = max(u_xlat6.x, 0.319999993);
    u_xlat16 = u_xlat36 * u_xlat36;
    u_xlat26 = (-u_xlat16_5.y) + 1.0;
    u_xlat16_34 = (-u_xlat16_33) + u_xlat16_5.y;
    u_xlat16_34 = u_xlat16_34 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_4.xyz) + vec3(u_xlat16_34);
    u_xlat36 = u_xlat26 * u_xlat26;
    u_xlat7.x = u_xlat36 * u_xlat36 + -1.0;
    u_xlat16 = u_xlat16 * u_xlat7.x + 1.00001001;
    u_xlat7.x = u_xlat26 * u_xlat26 + 1.5;
    u_xlat6.x = u_xlat6.x * u_xlat7.x;
    u_xlat6.x = u_xlat16 * u_xlat6.x;
    u_xlat6.x = u_xlat36 / u_xlat6.x;
    u_xlat16_34 = u_xlat26 * u_xlat36;
    u_xlat16_34 = (-u_xlat16_34) * 0.280000001 + 1.0;
    u_xlat6.x = u_xlat6.x + -9.99999975e-05;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat6.x = min(u_xlat6.x, 100.0);
    u_xlat6.xyw = u_xlat6.xxx * u_xlat16_4.xyz + u_xlat16_5.xzw;
    u_xlat6.xyw = u_xlat16_1.xyz * u_xlat6.xyw;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_7.xyz = exp2(u_xlat16_7.xyz);
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat16_1.xyz = u_xlat16_5.xzw * u_xlat16_1.xyz;
    u_xlat30 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat6.xyw = u_xlat6.xyw * vec3(u_xlat30) + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat26<0.00499999989);
#else
    u_xlatb30 = u_xlat26<0.00499999989;
#endif
    u_xlat26 = u_xlat26 * 8.29800034;
    u_xlat16_1.x = (u_xlatb30) ? 0.0 : u_xlat26;
    u_xlat16_11 = dot((-u_xlat12.xyz), u_xlat0.xyz);
    u_xlat16_11 = u_xlat16_11 + u_xlat16_11;
    u_xlat16_9.xyz = u_xlat0.xyz * (-vec3(u_xlat16_11)) + (-u_xlat12.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat0.x) + 1.0;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_4.xyz = vec3(u_xlat16_11) * u_xlat16_8.xyz + u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat16_9.zxy, (-u_xlat16_9.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<9.99999975e-06);
#else
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
#endif
    u_xlat0.x = (u_xlatb0) ? u_xlat16_9.z : (-u_xlat16_9.z);
    u_xlat7.z = u_xlat0.x * u_xlat16_9.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_9.z;
    u_xlat7.xy = (-u_xlat16_9.xy) * u_xlat16_9.yz;
    u_xlat0.yz = (-u_xlat16_9.xy) * u_xlat16_9.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat7.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_34);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + u_xlat6.xyw;
    u_xlat16_1.x = roundEven(u_xlat16_31);
    u_xlat16_11 = u_xlat16_31 * 2.0 + -1.0;
    u_xlat16_1.xzw = (-u_xlat16_3.xyz) * vec3(u_xlat16_33) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = abs(vec3(u_xlat16_11)) * u_xlat16_1.xzw + u_xlat16_5.xzw;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp float vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat15, u_xlat16_4);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp float vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_14;
mediump float u_xlat16_26;
float u_xlat36;
bool u_xlatb36;
float u_xlat37;
bool u_xlatb37;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat36 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat36 = sin(u_xlat36);
    u_xlat36 = u_xlat36 * _NormalRand.w;
    u_xlat36 = fract(u_xlat36);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat37 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat3.xyz = vec3(u_xlat37) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat3.xyz * (-u_xlat16_2.xxx) + (-u_xlat0.xyz);
    u_xlat37 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb37 = !!(u_xlat37<9.99999975e-06);
#else
    u_xlatb37 = u_xlat37<9.99999975e-06;
#endif
    u_xlat37 = (u_xlatb37) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat37 * u_xlat16_2.x;
    u_xlat5.x = u_xlat37 * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat4.xyz = vec3(u_xlat37) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat36) + u_xlat16_2.xyz;
    u_xlat36 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat4.xyz = vec3(u_xlat36) * u_xlat4.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_26 = u_xlat16_5.z + -1.0;
    u_xlat16_26 = _Occlusion * u_xlat16_26 + 1.0;
    u_xlat16_26 = max(u_xlat16_26, _MinMSA.z);
    u_xlat5.z = (-u_xlat16_2.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat5.z<0.00499999989);
#else
    u_xlatb36 = u_xlat5.z<0.00499999989;
#endif
    u_xlat37 = u_xlat5.z * 8.29800034;
    u_xlat16_38 = (u_xlatb36) ? 0.0 : u_xlat37;
    u_xlat16_4 = texture(unity_SpecCube0, u_xlat4.xyz, u_xlat16_38);
    u_xlat16_38 = u_xlat16_4.w + -1.0;
    u_xlat16_38 = unity_SpecCube0_HDR.w * u_xlat16_38 + 1.0;
    u_xlat16_38 = u_xlat16_38 * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * vec3(u_xlat16_38);
    u_xlat16_6.xyz = vec3(u_xlat16_26) * u_xlat16_6.xyz;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xyz = texture(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * _SphereMapScale.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + _AddColor.xyz;
    u_xlat16_1.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_2.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_14 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_14 = u_xlat16_14 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_14);
    u_xlat36 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat36;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat36 = u_xlat36 + u_xlat36;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat36)) + u_xlat0.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = vec3(u_xlat36) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_14 = (-u_xlat1.x) + 1.0;
    u_xlat16_12.x = u_xlat16_14 * u_xlat16_14;
    u_xlat16_12.x = u_xlat16_14 * u_xlat16_12.x;
    u_xlat16_12.x = u_xlat16_14 * u_xlat16_12.x;
    u_xlat16_9.xyz = u_xlat16_12.xxx * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat16_12.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_12.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = vec3(u_xlat16_26) * u_xlat16_9.xyz;
    u_xlat16_11.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_9.xyz * u_xlat16_11.xyz + u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_11.xyz;
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat16_14 = roundEven(u_xlat16_26);
    u_xlat16_26 = u_xlat16_26 * 2.0 + -1.0;
    u_xlat16_2.xyw = (-u_xlat16_7.xyz) * u_xlat16_2.xxx + vec3(u_xlat16_14);
    u_xlat16_2.xyz = abs(vec3(u_xlat16_26)) * u_xlat16_2.xyw + u_xlat16_11.xyz;
    u_xlat16_0.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp float vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat15, u_xlat16_4);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp float vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat10;
mediump vec3 u_xlat16_13;
float u_xlat19;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
float u_xlat32;
bool u_xlatb32;
mediump float u_xlat16_33;
mediump float u_xlat16_35;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz + _AddColor.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_3.xyz);
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_3.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_4.xy = max(u_xlat16_0.xy, _MinMSA.xy);
    u_xlat16_29 = u_xlat16_0.z + -1.0;
    u_xlat16_29 = _Occlusion * u_xlat16_29 + 1.0;
    u_xlat16_29 = max(u_xlat16_29, _MinMSA.z);
    u_xlat16_3.xyz = u_xlat16_4.xxx * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.y = vs_TEXCOORD3.w;
    u_xlat1.z = vs_TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat10.xyz = u_xlat5.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat10.x = u_xlat28 * u_xlat28;
    u_xlat19 = (-u_xlat16_4.y) + 1.0;
    u_xlat28 = u_xlat19 * u_xlat19;
    u_xlat32 = u_xlat28 * u_xlat28 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat32 + 1.00001001;
    u_xlat32 = u_xlat19 * u_xlat19 + 1.5;
    u_xlat1.x = u_xlat1.x * u_xlat32;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat28 / u_xlat1.x;
    u_xlat16_30 = u_xlat19 * u_xlat28;
    u_xlat16_30 = (-u_xlat16_30) * 0.280000001 + 1.0;
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat16_4.x = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_13.x = (-u_xlat16_4.x) + u_xlat16_4.y;
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13.x = min(max(u_xlat16_13.x, 0.0), 1.0);
#else
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0, 1.0);
#endif
    u_xlat16_13.xyz = (-u_xlat16_3.xyz) + u_xlat16_13.xxx;
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xxx;
    u_xlat1.xyw = u_xlat1.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat1.xyw = u_xlat1.xyw * _LightColor0.xyz;
    u_xlat16_7.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = vec3(u_xlat16_29) * u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz;
    u_xlat32 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat1.xyw = u_xlat1.xyw * vec3(u_xlat32) + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(u_xlat19<0.00499999989);
#else
    u_xlatb32 = u_xlat19<0.00499999989;
#endif
    u_xlat19 = u_xlat19 * 8.29800034;
    u_xlat16_33 = (u_xlatb32) ? 0.0 : u_xlat19;
    u_xlat16_8.x = dot((-u_xlat5.xyz), u_xlat0.xyz);
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_8.x;
    u_xlat16_8.xyz = u_xlat0.xyz * (-u_xlat16_8.xxx) + (-u_xlat5.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat0.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_3.xyz = vec3(u_xlat16_35) * u_xlat16_13.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat16_8.zxy, (-u_xlat16_8.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<9.99999975e-06);
#else
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
#endif
    u_xlat0.x = (u_xlatb0) ? u_xlat16_8.z : (-u_xlat16_8.z);
    u_xlat5.z = u_xlat0.x * u_xlat16_8.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_8.z;
    u_xlat5.xy = (-u_xlat16_8.xy) * u_xlat16_8.yz;
    u_xlat0.yz = (-u_xlat16_8.xy) * u_xlat16_8.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat16_8.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_33);
    u_xlat16_13.x = u_xlat16_0.w + -1.0;
    u_xlat16_13.x = unity_SpecCube0_HDR.w * u_xlat16_13.x + 1.0;
    u_xlat16_13.x = u_xlat16_13.x * unity_SpecCube0_HDR.x;
    u_xlat16_13.xyz = u_xlat16_0.xyz * u_xlat16_13.xxx;
    u_xlat16_13.xyz = vec3(u_xlat16_29) * u_xlat16_13.xyz;
    u_xlat16_13.xyz = vec3(u_xlat16_30) * u_xlat16_13.xyz;
    u_xlat0.xyz = u_xlat16_13.xyz * u_xlat16_3.xyz + u_xlat1.xyw;
    u_xlat16_3.x = roundEven(u_xlat16_29);
    u_xlat16_29 = u_xlat16_29 * 2.0 + -1.0;
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_4.xxx + u_xlat16_3.xxx;
    u_xlat16_2.xyz = abs(vec3(u_xlat16_29)) * u_xlat16_2.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp float vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat15, u_xlat16_4);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp float vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec2 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat10;
mediump vec3 u_xlat16_13;
float u_xlat19;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
float u_xlat32;
bool u_xlatb32;
mediump float u_xlat16_33;
mediump float u_xlat16_35;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz + _AddColor.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_3.xyz);
    u_xlat16_3.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_3.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_4.xy = max(u_xlat16_0.xy, _MinMSA.xy);
    u_xlat16_29 = u_xlat16_0.z + -1.0;
    u_xlat16_29 = _Occlusion * u_xlat16_29 + 1.0;
    u_xlat16_29 = max(u_xlat16_29, _MinMSA.z);
    u_xlat16_3.xyz = u_xlat16_4.xxx * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.x = vs_TEXCOORD2.w;
    u_xlat1.y = vs_TEXCOORD3.w;
    u_xlat1.z = vs_TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat1.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat10.xyz = u_xlat5.xyz * u_xlat1.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat1.xxx * u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz;
    u_xlat28 = dot(u_xlat0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = max(u_xlat1.x, 0.319999993);
    u_xlat10.x = u_xlat28 * u_xlat28;
    u_xlat19 = (-u_xlat16_4.y) + 1.0;
    u_xlat28 = u_xlat19 * u_xlat19;
    u_xlat32 = u_xlat28 * u_xlat28 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat32 + 1.00001001;
    u_xlat32 = u_xlat19 * u_xlat19 + 1.5;
    u_xlat1.x = u_xlat1.x * u_xlat32;
    u_xlat1.x = u_xlat10.x * u_xlat1.x;
    u_xlat1.x = u_xlat28 / u_xlat1.x;
    u_xlat16_30 = u_xlat19 * u_xlat28;
    u_xlat16_30 = (-u_xlat16_30) * 0.280000001 + 1.0;
    u_xlat1.x = u_xlat1.x + -9.99999975e-05;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat1.x = min(u_xlat1.x, 100.0);
    u_xlat16_4.x = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_13.x = (-u_xlat16_4.x) + u_xlat16_4.y;
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13.x = min(max(u_xlat16_13.x, 0.0), 1.0);
#else
    u_xlat16_13.x = clamp(u_xlat16_13.x, 0.0, 1.0);
#endif
    u_xlat16_13.xyz = (-u_xlat16_3.xyz) + u_xlat16_13.xxx;
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xxx;
    u_xlat1.xyw = u_xlat1.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat1.xyw = u_xlat1.xyw * _LightColor0.xyz;
    u_xlat16_7.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = vec3(u_xlat16_29) * u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz;
    u_xlat32 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat1.xyw = u_xlat1.xyw * vec3(u_xlat32) + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(u_xlat19<0.00499999989);
#else
    u_xlatb32 = u_xlat19<0.00499999989;
#endif
    u_xlat19 = u_xlat19 * 8.29800034;
    u_xlat16_33 = (u_xlatb32) ? 0.0 : u_xlat19;
    u_xlat16_8.x = dot((-u_xlat5.xyz), u_xlat0.xyz);
    u_xlat16_8.x = u_xlat16_8.x + u_xlat16_8.x;
    u_xlat16_8.xyz = u_xlat0.xyz * (-u_xlat16_8.xxx) + (-u_xlat5.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat0.x) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_3.xyz = vec3(u_xlat16_35) * u_xlat16_13.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat16_8.zxy, (-u_xlat16_8.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<9.99999975e-06);
#else
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
#endif
    u_xlat0.x = (u_xlatb0) ? u_xlat16_8.z : (-u_xlat16_8.z);
    u_xlat5.z = u_xlat0.x * u_xlat16_8.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_8.z;
    u_xlat5.xy = (-u_xlat16_8.xy) * u_xlat16_8.yz;
    u_xlat0.yz = (-u_xlat16_8.xy) * u_xlat16_8.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat19 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat19);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat16_8.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_33);
    u_xlat16_13.x = u_xlat16_0.w + -1.0;
    u_xlat16_13.x = unity_SpecCube0_HDR.w * u_xlat16_13.x + 1.0;
    u_xlat16_13.x = u_xlat16_13.x * unity_SpecCube0_HDR.x;
    u_xlat16_13.xyz = u_xlat16_0.xyz * u_xlat16_13.xxx;
    u_xlat16_13.xyz = vec3(u_xlat16_29) * u_xlat16_13.xyz;
    u_xlat16_13.xyz = vec3(u_xlat16_30) * u_xlat16_13.xyz;
    u_xlat0.xyz = u_xlat16_13.xyz * u_xlat16_3.xyz + u_xlat1.xyw;
    u_xlat16_3.x = roundEven(u_xlat16_29);
    u_xlat16_29 = u_xlat16_29 * 2.0 + -1.0;
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * u_xlat16_4.xxx + u_xlat16_3.xxx;
    u_xlat16_2.xyz = abs(vec3(u_xlat16_29)) * u_xlat16_2.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp float vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat15, u_xlat16_4);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp float vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump float u_xlat16_12;
mediump float u_xlat16_15;
mediump float u_xlat16_27;
float u_xlat36;
bool u_xlatb36;
float u_xlat37;
bool u_xlatb37;
mediump float u_xlat16_39;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat36 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat36 = sin(u_xlat36);
    u_xlat36 = u_xlat36 * _NormalRand.w;
    u_xlat36 = fract(u_xlat36);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat37 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat2.xyz = vec3(u_xlat37) * u_xlat1.xyz;
    u_xlat16_3.x = dot((-u_xlat0.xyz), u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat2.xyz * (-u_xlat16_3.xxx) + (-u_xlat0.xyz);
    u_xlat37 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb37 = !!(u_xlat37<9.99999975e-06);
#else
    u_xlatb37 = u_xlat37<9.99999975e-06;
#endif
    u_xlat37 = (u_xlatb37) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat4.z = u_xlat37 * u_xlat16_3.x;
    u_xlat5.x = u_xlat37 * u_xlat16_3.z;
    u_xlat4.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat5.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat37 = inversesqrt(u_xlat37);
    u_xlat4.xyz = vec3(u_xlat37) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat36) + u_xlat16_3.xyz;
    u_xlat36 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat4.xyz = vec3(u_xlat36) * u_xlat4.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_3.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_27 = u_xlat16_5.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_27 = max(u_xlat16_27, _MinMSA.z);
    u_xlat5.z = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat5.z<0.00499999989);
#else
    u_xlatb36 = u_xlat5.z<0.00499999989;
#endif
    u_xlat37 = u_xlat5.z * 8.29800034;
    u_xlat16_39 = (u_xlatb36) ? 0.0 : u_xlat37;
    u_xlat16_4 = texture(unity_SpecCube0, u_xlat4.xyz, u_xlat16_39);
    u_xlat16_39 = u_xlat16_4.w + -1.0;
    u_xlat16_39 = unity_SpecCube0_HDR.w * u_xlat16_39 + 1.0;
    u_xlat16_39 = u_xlat16_39 * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * vec3(u_xlat16_39);
    u_xlat16_6.xyz = vec3(u_xlat16_27) * u_xlat16_6.xyz;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xyz = texture(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * _SphereMapScale.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + _AddColor.xyz;
    u_xlat16_1.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_15 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_15 = u_xlat16_15 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_15);
    u_xlat36 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat1.x = u_xlat36;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat36 = u_xlat36 + u_xlat36;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat36)) + u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat16_15 = (-u_xlat1.x) + 1.0;
    u_xlat16_12 = u_xlat16_15 * u_xlat16_15;
    u_xlat16_12 = u_xlat16_15 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_15 * u_xlat16_12;
    u_xlat16_9.xyz = vec3(u_xlat16_12) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat16_15 = u_xlat2.y * u_xlat2.y;
    u_xlat16_15 = u_xlat2.x * u_xlat2.x + (-u_xlat16_15);
    u_xlat16_1 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_15) + u_xlat16_9.xyz;
    u_xlat12.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = u_xlat12.xxx * _LightColor0.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_11.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_11.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_11.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_11.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.yzw = log2(u_xlat16_9.xyz);
    u_xlat0 = u_xlat0 * vec4(16.0, 0.416666657, 0.416666657, 0.416666657);
    u_xlat12.xyz = exp2(u_xlat0.yzw);
    u_xlat12.xyz = u_xlat12.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat12.xyz = max(u_xlat12.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat12.xyz;
    u_xlat16_9.xyz = vec3(u_xlat16_27) * u_xlat16_9.xyz;
    u_xlat16_11.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_9.xyz * u_xlat16_11.xyz + u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_11.xyz;
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat16_15 = roundEven(u_xlat16_27);
    u_xlat16_27 = u_xlat16_27 * 2.0 + -1.0;
    u_xlat16_3.xyw = (-u_xlat16_7.xyz) * u_xlat16_3.xxx + vec3(u_xlat16_15);
    u_xlat16_3.xyz = abs(vec3(u_xlat16_27)) * u_xlat16_3.xyw + u_xlat16_11.xyz;
    u_xlat16_0.xyz = u_xlat16_6.xyz * u_xlat16_3.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp float vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat15, u_xlat16_4);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp float vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
bool u_xlatb6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
float u_xlat16;
mediump vec2 u_xlat16_25;
float u_xlat27;
float u_xlat33;
mediump float u_xlat16_35;
mediump float u_xlat16_37;
float u_xlat38;
void main()
{
    u_xlat16_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_2.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_2.x);
    u_xlat16_3 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_5.xyz = exp2(u_xlat16_5.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_35 = u_xlat16_5.z + -1.0;
    u_xlat16_3.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_35 = _Occlusion * u_xlat16_35 + 1.0;
    u_xlat16_35 = max(u_xlat16_35, _MinMSA.z);
    u_xlat16_2.xyz = vec3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat16_25.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_25.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz + _AddColor.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_25.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_25.xxx * u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat6.xyz = u_xlat5.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat11.xyz = u_xlat11.xxx * u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat6.xyz;
    u_xlat38 = dot(u_xlat1.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat16 = u_xlat38 * u_xlat38;
    u_xlat27 = (-u_xlat16_3.y) + 1.0;
    u_xlat16_3.x = (-u_xlat16_25.x) + u_xlat16_3.y;
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyw = (-u_xlat16_8.xyz) + u_xlat16_3.xxx;
    u_xlat38 = u_xlat27 * u_xlat27;
    u_xlat6.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat16 = u_xlat16 * u_xlat6.x + 1.00001001;
    u_xlat6.x = u_xlat27 * u_xlat27 + 1.5;
    u_xlat5.x = u_xlat5.x * u_xlat6.x;
    u_xlat5.x = u_xlat16 * u_xlat5.x;
    u_xlat5.x = u_xlat38 / u_xlat5.x;
    u_xlat16_37 = u_xlat27 * u_xlat38;
    u_xlat16_37 = (-u_xlat16_37) * 0.280000001 + 1.0;
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = u_xlat5.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat5.xyw = u_xlat5.xyw * _LightColor0.xyz;
    u_xlat6.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat5.xyw = u_xlat5.xyw * u_xlat6.xxx + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat27<0.00499999989);
#else
    u_xlatb6 = u_xlat27<0.00499999989;
#endif
    u_xlat27 = u_xlat27 * 8.29800034;
    u_xlat16_2.x = (u_xlatb6) ? 0.0 : u_xlat27;
    u_xlat16_13 = dot((-u_xlat11.xyz), u_xlat1.xyz);
    u_xlat16_13 = u_xlat16_13 + u_xlat16_13;
    u_xlat16_9.xyz = u_xlat1.xyz * (-vec3(u_xlat16_13)) + (-u_xlat11.xyz);
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat11.x) + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_3.xyw = vec3(u_xlat16_13) * u_xlat16_3.xyw + u_xlat16_8.xyz;
    u_xlat11.x = dot(u_xlat16_9.zxy, (-u_xlat16_9.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat11.x<9.99999975e-06);
#else
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
#endif
    u_xlat11.x = (u_xlatb11) ? u_xlat16_9.z : (-u_xlat16_9.z);
    u_xlat6.z = u_xlat11.x * u_xlat16_9.x;
    u_xlat10.x = u_xlat11.x * u_xlat16_9.z;
    u_xlat6.xy = (-u_xlat16_9.xy) * u_xlat16_9.yz;
    u_xlat10.yz = (-u_xlat16_9.xy) * u_xlat16_9.xy;
    u_xlat11.xyz = u_xlat6.xyz + (-u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat27);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat11.xyz * u_xlat0.xxx + u_xlat16_9.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_0.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = vec3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_37);
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyw + u_xlat5.xyw;
    u_xlat16_2.x = roundEven(u_xlat16_35);
    u_xlat16_13 = u_xlat16_35 * 2.0 + -1.0;
    u_xlat16_2.xzw = (-u_xlat16_4.xyz) * u_xlat16_25.xxx + u_xlat16_2.xxx;
    u_xlat16_2.xyz = abs(vec3(u_xlat16_13)) * u_xlat16_2.xzw + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp float vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat15, u_xlat16_4);
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp float vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
bool u_xlatb6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
float u_xlat16;
mediump vec2 u_xlat16_25;
float u_xlat27;
float u_xlat33;
mediump float u_xlat16_35;
mediump float u_xlat16_37;
float u_xlat38;
void main()
{
    u_xlat16_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_2.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_2.x);
    u_xlat16_3 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_5.xyz = exp2(u_xlat16_5.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_35 = u_xlat16_5.z + -1.0;
    u_xlat16_3.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_35 = _Occlusion * u_xlat16_35 + 1.0;
    u_xlat16_35 = max(u_xlat16_35, _MinMSA.z);
    u_xlat16_2.xyz = vec3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat16_25.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_25.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz + _AddColor.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_25.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_25.xxx * u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat16_8.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat6.xyz = u_xlat5.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat11.xyz = u_xlat11.xxx * u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat6.xyz;
    u_xlat38 = dot(u_xlat1.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat16 = u_xlat38 * u_xlat38;
    u_xlat27 = (-u_xlat16_3.y) + 1.0;
    u_xlat16_3.x = (-u_xlat16_25.x) + u_xlat16_3.y;
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyw = (-u_xlat16_8.xyz) + u_xlat16_3.xxx;
    u_xlat38 = u_xlat27 * u_xlat27;
    u_xlat6.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat16 = u_xlat16 * u_xlat6.x + 1.00001001;
    u_xlat6.x = u_xlat27 * u_xlat27 + 1.5;
    u_xlat5.x = u_xlat5.x * u_xlat6.x;
    u_xlat5.x = u_xlat16 * u_xlat5.x;
    u_xlat5.x = u_xlat38 / u_xlat5.x;
    u_xlat16_37 = u_xlat27 * u_xlat38;
    u_xlat16_37 = (-u_xlat16_37) * 0.280000001 + 1.0;
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = u_xlat5.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat5.xyw = u_xlat5.xyw * _LightColor0.xyz;
    u_xlat6.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat5.xyw = u_xlat5.xyw * u_xlat6.xxx + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat27<0.00499999989);
#else
    u_xlatb6 = u_xlat27<0.00499999989;
#endif
    u_xlat27 = u_xlat27 * 8.29800034;
    u_xlat16_2.x = (u_xlatb6) ? 0.0 : u_xlat27;
    u_xlat16_13 = dot((-u_xlat11.xyz), u_xlat1.xyz);
    u_xlat16_13 = u_xlat16_13 + u_xlat16_13;
    u_xlat16_9.xyz = u_xlat1.xyz * (-vec3(u_xlat16_13)) + (-u_xlat11.xyz);
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat11.x) + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_3.xyw = vec3(u_xlat16_13) * u_xlat16_3.xyw + u_xlat16_8.xyz;
    u_xlat11.x = dot(u_xlat16_9.zxy, (-u_xlat16_9.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat11.x<9.99999975e-06);
#else
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
#endif
    u_xlat11.x = (u_xlatb11) ? u_xlat16_9.z : (-u_xlat16_9.z);
    u_xlat6.z = u_xlat11.x * u_xlat16_9.x;
    u_xlat10.x = u_xlat11.x * u_xlat16_9.z;
    u_xlat6.xy = (-u_xlat16_9.xy) * u_xlat16_9.yz;
    u_xlat10.yz = (-u_xlat16_9.xy) * u_xlat16_9.xy;
    u_xlat11.xyz = u_xlat6.xyz + (-u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat27);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat11.xyz * u_xlat0.xxx + u_xlat16_9.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_0.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = vec3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_37);
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyw + u_xlat5.xyw;
    u_xlat16_2.x = roundEven(u_xlat16_35);
    u_xlat16_13 = u_xlat16_35 * 2.0 + -1.0;
    u_xlat16_2.xzw = (-u_xlat16_4.xyz) * u_xlat16_25.xxx + u_xlat16_2.xxx;
    u_xlat16_2.xyz = abs(vec3(u_xlat16_13)) * u_xlat16_2.xzw + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp float vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat15, u_xlat16_4);
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp float vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_11;
mediump float u_xlat16_13;
mediump float u_xlat16_24;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
bool u_xlatb34;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat33 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * _NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat3.xyz = vec3(u_xlat34) * u_xlat1.xyz;
    u_xlat16_2.x = dot((-u_xlat0.xyz), u_xlat3.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat3.xyz * (-u_xlat16_2.xxx) + (-u_xlat0.xyz);
    u_xlat34 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat34<9.99999975e-06);
#else
    u_xlatb34 = u_xlat34<9.99999975e-06;
#endif
    u_xlat34 = (u_xlatb34) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat4.z = u_xlat34 * u_xlat16_2.x;
    u_xlat5.x = u_xlat34 * u_xlat16_2.z;
    u_xlat4.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat5.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat4.xyz = vec3(u_xlat34) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33) + u_xlat16_2.xyz;
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_24 = u_xlat16_5.z + -1.0;
    u_xlat16_24 = _Occlusion * u_xlat16_24 + 1.0;
    u_xlat16_24 = max(u_xlat16_24, _MinMSA.z);
    u_xlat5.z = (-u_xlat16_2.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat5.z<0.00499999989);
#else
    u_xlatb33 = u_xlat5.z<0.00499999989;
#endif
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_35 = (u_xlatb33) ? 0.0 : u_xlat34;
    u_xlat16_4 = texture(unity_SpecCube0, u_xlat4.xyz, u_xlat16_35);
    u_xlat16_35 = u_xlat16_4.w + -1.0;
    u_xlat16_35 = unity_SpecCube0_HDR.w * u_xlat16_35 + 1.0;
    u_xlat16_35 = u_xlat16_35 * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * vec3(u_xlat16_35);
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_6.xyz;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xyz = texture(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * _SphereMapScale.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + _AddColor.xyz;
    u_xlat16_1.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_2.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_13 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_13 = u_xlat16_13 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_13);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat1.x = u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat33)) + u_xlat0.xyz;
    u_xlat33 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_13 = (-u_xlat1.x) + 1.0;
    u_xlat16_11 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_11 = u_xlat16_13 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_13 * u_xlat16_11;
    u_xlat16_9.xyz = vec3(u_xlat16_11) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat16_1.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_1.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = vec3(u_xlat16_24) * u_xlat16_9.xyz;
    u_xlat16_10.xyz = u_xlat16_2.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_9.xyz * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_13 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_13) * _LightColor0.xyz;
    u_xlat16_9.xyz = vec3(u_xlat33) * u_xlat16_9.xyz;
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_9.xyz + u_xlat16_6.xyz;
    u_xlat16_13 = roundEven(u_xlat16_24);
    u_xlat16_24 = u_xlat16_24 * 2.0 + -1.0;
    u_xlat16_2.xyw = (-u_xlat16_7.xyz) * u_xlat16_2.xxx + vec3(u_xlat16_13);
    u_xlat16_2.xyz = abs(vec3(u_xlat16_24)) * u_xlat16_2.xyw + u_xlat16_10.xyz;
    u_xlat16_0.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp float vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat15, u_xlat16_4);
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp float vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
vec3 u_xlat12;
float u_xlat22;
float u_xlat30;
mediump float u_xlat16_31;
float u_xlat32;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
float u_xlat36;
bool u_xlatb36;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + _AddColor.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat16_4.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat16_4.xyz);
    u_xlat2.z = dot(vs_TEXCOORD4.xyz, u_xlat16_4.xyz);
    u_xlat16_4.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xy = max(u_xlat16_0.xy, _MinMSA.xy);
    u_xlat16_31 = u_xlat16_0.z + -1.0;
    u_xlat16_31 = _Occlusion * u_xlat16_31 + 1.0;
    u_xlat16_31 = max(u_xlat16_31, _MinMSA.z);
    u_xlat16_4.xyz = u_xlat16_5.xxx * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat2.x = vs_TEXCOORD2.w;
    u_xlat2.y = vs_TEXCOORD3.w;
    u_xlat2.z = vs_TEXCOORD4.w;
    u_xlat6.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat12.xyz = u_xlat6.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat12.xyz;
    u_xlat32 = dot(u_xlat0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat12.x = u_xlat32 * u_xlat32;
    u_xlat22 = (-u_xlat16_5.y) + 1.0;
    u_xlat32 = u_xlat22 * u_xlat22;
    u_xlat36 = u_xlat32 * u_xlat32 + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat36 + 1.00001001;
    u_xlat36 = u_xlat22 * u_xlat22 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat36;
    u_xlat2.x = u_xlat12.x * u_xlat2.x;
    u_xlat2.x = u_xlat32 / u_xlat2.x;
    u_xlat16_33 = u_xlat22 * u_xlat32;
    u_xlat16_33 = (-u_xlat16_33) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat16_34 = (-u_xlat16_5.x) * 0.779083729 + 0.779083729;
    u_xlat16_5.x = (-u_xlat16_34) + u_xlat16_5.y;
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) + u_xlat16_5.xxx;
    u_xlat16_7.xyz = u_xlat16_3.xyz * vec3(u_xlat16_34);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_4.xyz + u_xlat16_7.xyz;
    u_xlat2.xyw = u_xlat16_1.xyz * u_xlat2.xyw;
    u_xlat16_8.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat36) + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat22<0.00499999989);
#else
    u_xlatb36 = u_xlat22<0.00499999989;
#endif
    u_xlat22 = u_xlat22 * 8.29800034;
    u_xlat16_1.x = (u_xlatb36) ? 0.0 : u_xlat22;
    u_xlat16_11 = dot((-u_xlat6.xyz), u_xlat0.xyz);
    u_xlat16_11 = u_xlat16_11 + u_xlat16_11;
    u_xlat16_9.xyz = u_xlat0.xyz * (-vec3(u_xlat16_11)) + (-u_xlat6.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat0.x) + 1.0;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_4.xyz = vec3(u_xlat16_11) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat16_9.zxy, (-u_xlat16_9.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<9.99999975e-06);
#else
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
#endif
    u_xlat0.x = (u_xlatb0) ? u_xlat16_9.z : (-u_xlat16_9.z);
    u_xlat6.z = u_xlat0.x * u_xlat16_9.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_9.z;
    u_xlat6.xy = (-u_xlat16_9.xy) * u_xlat16_9.yz;
    u_xlat0.yz = (-u_xlat16_9.xy) * u_xlat16_9.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat6.xyz;
    u_xlat22 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_33);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + u_xlat2.xyw;
    u_xlat16_1.x = roundEven(u_xlat16_31);
    u_xlat16_11 = u_xlat16_31 * 2.0 + -1.0;
    u_xlat16_1.xzw = (-u_xlat16_3.xyz) * vec3(u_xlat16_34) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = abs(vec3(u_xlat16_11)) * u_xlat16_1.xzw + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp float vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat15, u_xlat16_4);
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp float vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
vec3 u_xlat12;
float u_xlat22;
float u_xlat30;
mediump float u_xlat16_31;
float u_xlat32;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
float u_xlat36;
bool u_xlatb36;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + _AddColor.xyz;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, u_xlat16_4.xyz);
    u_xlat2.y = dot(vs_TEXCOORD3.xyz, u_xlat16_4.xyz);
    u_xlat2.z = dot(vs_TEXCOORD4.xyz, u_xlat16_4.xyz);
    u_xlat16_4.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat0.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat0.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat16_4.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_4.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_0.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_5.xy = max(u_xlat16_0.xy, _MinMSA.xy);
    u_xlat16_31 = u_xlat16_0.z + -1.0;
    u_xlat16_31 = _Occlusion * u_xlat16_31 + 1.0;
    u_xlat16_31 = max(u_xlat16_31, _MinMSA.z);
    u_xlat16_4.xyz = u_xlat16_5.xxx * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat2.x = vs_TEXCOORD2.w;
    u_xlat2.y = vs_TEXCOORD3.w;
    u_xlat2.z = vs_TEXCOORD4.w;
    u_xlat6.xyz = (-u_xlat2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat12.xyz = u_xlat6.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat6.xyz = u_xlat2.xxx * u_xlat6.xyz;
    u_xlat2.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat12.xyz;
    u_xlat32 = dot(u_xlat0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = max(u_xlat2.x, 0.319999993);
    u_xlat12.x = u_xlat32 * u_xlat32;
    u_xlat22 = (-u_xlat16_5.y) + 1.0;
    u_xlat32 = u_xlat22 * u_xlat22;
    u_xlat36 = u_xlat32 * u_xlat32 + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat36 + 1.00001001;
    u_xlat36 = u_xlat22 * u_xlat22 + 1.5;
    u_xlat2.x = u_xlat2.x * u_xlat36;
    u_xlat2.x = u_xlat12.x * u_xlat2.x;
    u_xlat2.x = u_xlat32 / u_xlat2.x;
    u_xlat16_33 = u_xlat22 * u_xlat32;
    u_xlat16_33 = (-u_xlat16_33) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat16_34 = (-u_xlat16_5.x) * 0.779083729 + 0.779083729;
    u_xlat16_5.x = (-u_xlat16_34) + u_xlat16_5.y;
    u_xlat16_5.x = u_xlat16_5.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = (-u_xlat16_4.xyz) + u_xlat16_5.xxx;
    u_xlat16_7.xyz = u_xlat16_3.xyz * vec3(u_xlat16_34);
    u_xlat2.xyw = u_xlat2.xxx * u_xlat16_4.xyz + u_xlat16_7.xyz;
    u_xlat2.xyw = u_xlat16_1.xyz * u_xlat2.xyw;
    u_xlat16_8.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat2.xyw = u_xlat2.xyw * vec3(u_xlat36) + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(u_xlat22<0.00499999989);
#else
    u_xlatb36 = u_xlat22<0.00499999989;
#endif
    u_xlat22 = u_xlat22 * 8.29800034;
    u_xlat16_1.x = (u_xlatb36) ? 0.0 : u_xlat22;
    u_xlat16_11 = dot((-u_xlat6.xyz), u_xlat0.xyz);
    u_xlat16_11 = u_xlat16_11 + u_xlat16_11;
    u_xlat16_9.xyz = u_xlat0.xyz * (-vec3(u_xlat16_11)) + (-u_xlat6.xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat6.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat0.x) + 1.0;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_11;
    u_xlat16_4.xyz = vec3(u_xlat16_11) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat0.x = dot(u_xlat16_9.zxy, (-u_xlat16_9.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<9.99999975e-06);
#else
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
#endif
    u_xlat0.x = (u_xlatb0) ? u_xlat16_9.z : (-u_xlat16_9.z);
    u_xlat6.z = u_xlat0.x * u_xlat16_9.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_9.z;
    u_xlat6.xy = (-u_xlat16_9.xy) * u_xlat16_9.yz;
    u_xlat0.yz = (-u_xlat16_9.xy) * u_xlat16_9.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat6.xyz;
    u_xlat22 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat22 = inversesqrt(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat22);
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(u_xlat16_31) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_33);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + u_xlat2.xyw;
    u_xlat16_1.x = roundEven(u_xlat16_31);
    u_xlat16_11 = u_xlat16_31 * 2.0 + -1.0;
    u_xlat16_1.xzw = (-u_xlat16_3.xyz) * vec3(u_xlat16_34) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = abs(vec3(u_xlat16_11)) * u_xlat16_1.xzw + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp float vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat15, u_xlat16_4);
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp float vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
mediump float u_xlat16_11;
mediump float u_xlat16_14;
mediump float u_xlat16_25;
float u_xlat33;
bool u_xlatb33;
float u_xlat34;
bool u_xlatb34;
mediump float u_xlat16_36;
void main()
{
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat33 = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * _NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat16_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat34 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat2.xyz = vec3(u_xlat34) * u_xlat1.xyz;
    u_xlat16_3.x = dot((-u_xlat0.xyz), u_xlat2.xyz);
    u_xlat16_3.x = u_xlat16_3.x + u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat2.xyz * (-u_xlat16_3.xxx) + (-u_xlat0.xyz);
    u_xlat34 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlat34<9.99999975e-06);
#else
    u_xlatb34 = u_xlat34<9.99999975e-06;
#endif
    u_xlat34 = (u_xlatb34) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat4.z = u_xlat34 * u_xlat16_3.x;
    u_xlat5.x = u_xlat34 * u_xlat16_3.z;
    u_xlat4.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat5.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat4.xyz = u_xlat4.xyz + (-u_xlat5.xyz);
    u_xlat34 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat34 = inversesqrt(u_xlat34);
    u_xlat4.xyz = vec3(u_xlat34) * u_xlat4.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_NormalDiff);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat33) + u_xlat16_3.xyz;
    u_xlat33 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * u_xlat4.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_3.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_25 = u_xlat16_5.z + -1.0;
    u_xlat16_25 = _Occlusion * u_xlat16_25 + 1.0;
    u_xlat16_25 = max(u_xlat16_25, _MinMSA.z);
    u_xlat5.z = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat5.z<0.00499999989);
#else
    u_xlatb33 = u_xlat5.z<0.00499999989;
#endif
    u_xlat34 = u_xlat5.z * 8.29800034;
    u_xlat16_36 = (u_xlatb33) ? 0.0 : u_xlat34;
    u_xlat16_4 = texture(unity_SpecCube0, u_xlat4.xyz, u_xlat16_36);
    u_xlat16_36 = u_xlat16_4.w + -1.0;
    u_xlat16_36 = unity_SpecCube0_HDR.w * u_xlat16_36 + 1.0;
    u_xlat16_36 = u_xlat16_36 * unity_SpecCube0_HDR.x;
    u_xlat16_6.xyz = u_xlat16_4.xyz * vec3(u_xlat16_36);
    u_xlat16_6.xyz = vec3(u_xlat16_25) * u_xlat16_6.xyz;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xyz = texture(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * _SphereMapScale.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + _AddColor.xyz;
    u_xlat16_1.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_14 = (-u_xlat16_3.x) + u_xlat16_3.y;
    u_xlat16_14 = u_xlat16_14 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_14);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat1.x = u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat33)) + u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat5.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat5.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_14 = (-u_xlat1.x) + 1.0;
    u_xlat16_11 = u_xlat16_14 * u_xlat16_14;
    u_xlat16_11 = u_xlat16_14 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_14 * u_xlat16_11;
    u_xlat16_9.xyz = vec3(u_xlat16_11) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat16_14 = u_xlat2.y * u_xlat2.y;
    u_xlat16_14 = u_xlat2.x * u_xlat2.x + (-u_xlat16_14);
    u_xlat16_1 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_14) + u_xlat16_9.xyz;
    u_xlat11 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
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
    u_xlat16_5.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = vec3(u_xlat16_25) * u_xlat16_9.xyz;
    u_xlat16_10.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_9.xyz * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_8.xyz + u_xlat16_10.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_14 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_14) * _LightColor0.xyz;
    u_xlat16_9.xyz = vec3(u_xlat11) * u_xlat16_9.xyz;
    u_xlat16_6.xyz = u_xlat16_8.xyz * u_xlat16_9.xyz + u_xlat16_6.xyz;
    u_xlat16_14 = roundEven(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * 2.0 + -1.0;
    u_xlat16_3.xyw = (-u_xlat16_7.xyz) * u_xlat16_3.xxx + vec3(u_xlat16_14);
    u_xlat16_3.xyz = abs(vec3(u_xlat16_25)) * u_xlat16_3.xyw + u_xlat16_10.xyz;
    u_xlat16_0.xyz = u_xlat16_6.xyz * u_xlat16_3.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp float vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat15, u_xlat16_4);
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp float vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
bool u_xlatb6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
float u_xlat16;
mediump vec2 u_xlat16_25;
float u_xlat27;
float u_xlat33;
mediump float u_xlat16_35;
mediump float u_xlat16_36;
mediump float u_xlat16_37;
float u_xlat38;
void main()
{
    u_xlat16_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_2.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_2.x);
    u_xlat16_3 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_5.xyz = exp2(u_xlat16_5.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_35 = u_xlat16_5.z + -1.0;
    u_xlat16_3.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_35 = _Occlusion * u_xlat16_35 + 1.0;
    u_xlat16_35 = max(u_xlat16_35, _MinMSA.z);
    u_xlat16_2.xyz = vec3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat16_25.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_25.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz + _AddColor.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_25.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_25.xxx * u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_36 = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_36 = min(max(u_xlat16_36, 0.0), 1.0);
#else
    u_xlat16_36 = clamp(u_xlat16_36, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = vec3(u_xlat16_36) * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_9.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat6.xyz = u_xlat5.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat11.xyz = u_xlat11.xxx * u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat6.xyz;
    u_xlat38 = dot(u_xlat1.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat16 = u_xlat38 * u_xlat38;
    u_xlat27 = (-u_xlat16_3.y) + 1.0;
    u_xlat16_3.x = (-u_xlat16_25.x) + u_xlat16_3.y;
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyw = (-u_xlat16_9.xyz) + u_xlat16_3.xxx;
    u_xlat38 = u_xlat27 * u_xlat27;
    u_xlat6.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat16 = u_xlat16 * u_xlat6.x + 1.00001001;
    u_xlat6.x = u_xlat27 * u_xlat27 + 1.5;
    u_xlat5.x = u_xlat5.x * u_xlat6.x;
    u_xlat5.x = u_xlat16 * u_xlat5.x;
    u_xlat5.x = u_xlat38 / u_xlat5.x;
    u_xlat16_37 = u_xlat27 * u_xlat38;
    u_xlat16_37 = (-u_xlat16_37) * 0.280000001 + 1.0;
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = u_xlat5.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat5.xyw = u_xlat16_8.xyz * u_xlat5.xyw;
    u_xlat6.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat5.xyw = u_xlat5.xyw * u_xlat6.xxx + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat27<0.00499999989);
#else
    u_xlatb6 = u_xlat27<0.00499999989;
#endif
    u_xlat27 = u_xlat27 * 8.29800034;
    u_xlat16_2.x = (u_xlatb6) ? 0.0 : u_xlat27;
    u_xlat16_13 = dot((-u_xlat11.xyz), u_xlat1.xyz);
    u_xlat16_13 = u_xlat16_13 + u_xlat16_13;
    u_xlat16_8.xyz = u_xlat1.xyz * (-vec3(u_xlat16_13)) + (-u_xlat11.xyz);
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat11.x) + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_3.xyw = vec3(u_xlat16_13) * u_xlat16_3.xyw + u_xlat16_9.xyz;
    u_xlat11.x = dot(u_xlat16_8.zxy, (-u_xlat16_8.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat11.x<9.99999975e-06);
#else
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
#endif
    u_xlat11.x = (u_xlatb11) ? u_xlat16_8.z : (-u_xlat16_8.z);
    u_xlat6.z = u_xlat11.x * u_xlat16_8.x;
    u_xlat10.x = u_xlat11.x * u_xlat16_8.z;
    u_xlat6.xy = (-u_xlat16_8.xy) * u_xlat16_8.yz;
    u_xlat10.yz = (-u_xlat16_8.xy) * u_xlat16_8.xy;
    u_xlat11.xyz = u_xlat6.xyz + (-u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat27);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat11.xyz * u_xlat0.xxx + u_xlat16_8.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_0.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = vec3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_37);
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyw + u_xlat5.xyw;
    u_xlat16_2.x = roundEven(u_xlat16_35);
    u_xlat16_13 = u_xlat16_35 * 2.0 + -1.0;
    u_xlat16_2.xzw = (-u_xlat16_4.xyz) * u_xlat16_25.xxx + u_xlat16_2.xxx;
    u_xlat16_2.xyz = abs(vec3(u_xlat16_13)) * u_xlat16_2.xzw + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
out highp float vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat15 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    vs_TEXCOORD2.w = u_xlat0.x;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat2.z;
    vs_TEXCOORD2.z = u_xlat1.y;
    vs_TEXCOORD3.x = u_xlat2.x;
    vs_TEXCOORD4.x = u_xlat2.y;
    vs_TEXCOORD3.z = u_xlat1.z;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD3.w = u_xlat0.y;
    vs_TEXCOORD4.w = u_xlat0.z;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD7.xy = u_xlat0.xy;
    u_xlat16_4 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat15, u_xlat16_4);
    vs_TEXCOORD7.zw = vec2(0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
in highp float vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_6;
bool u_xlatb6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
vec3 u_xlat11;
bool u_xlatb11;
mediump float u_xlat16_13;
float u_xlat16;
mediump vec2 u_xlat16_25;
float u_xlat27;
float u_xlat33;
mediump float u_xlat16_35;
mediump float u_xlat16_36;
mediump float u_xlat16_37;
float u_xlat38;
void main()
{
    u_xlat16_0.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, u_xlat16_1.xyz);
    u_xlat0.y = dot(vs_TEXCOORD3.xyz, u_xlat16_1.xyz);
    u_xlat0.z = dot(vs_TEXCOORD4.xyz, u_xlat16_1.xyz);
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat1.y * u_xlat1.y;
    u_xlat16_2.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_2.x);
    u_xlat16_3 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_3);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_3);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_3);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_5.xyz = exp2(u_xlat16_5.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = texture(unity_Lightmap, vs_TEXCOORD5.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_35 = u_xlat16_5.z + -1.0;
    u_xlat16_3.xy = max(u_xlat16_5.xy, _MinMSA.xy);
    u_xlat16_35 = _Occlusion * u_xlat16_35 + 1.0;
    u_xlat16_35 = max(u_xlat16_35, _MinMSA.z);
    u_xlat16_2.xyz = vec3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_4.x = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat5.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat5.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat5.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_4.y = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat16_25.xy = u_xlat16_4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_0.xyz = texture(_SphereMap, u_xlat16_25.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * _SphereMapScale.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz + _AddColor.xyz;
    u_xlat16_0.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_0.xyz + u_xlat16_7.xyz;
    u_xlat16_25.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = u_xlat16_25.xxx * u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD7.xy);
    u_xlat16_36 = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_36 = min(max(u_xlat16_36, 0.0), 1.0);
#else
    u_xlat16_36 = clamp(u_xlat16_36, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = vec3(u_xlat16_36) * _LightColor0.xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_9.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.x = vs_TEXCOORD2.w;
    u_xlat0.y = vs_TEXCOORD3.w;
    u_xlat0.z = vs_TEXCOORD4.w;
    u_xlat5.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11.x = inversesqrt(u_xlat11.x);
    u_xlat6.xyz = u_xlat5.xyz * u_xlat11.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat11.xyz = u_xlat11.xxx * u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.00100000005);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat6.xyz;
    u_xlat38 = dot(u_xlat1.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat5.x = max(u_xlat5.x, 0.319999993);
    u_xlat16 = u_xlat38 * u_xlat38;
    u_xlat27 = (-u_xlat16_3.y) + 1.0;
    u_xlat16_3.x = (-u_xlat16_25.x) + u_xlat16_3.y;
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.xyw = (-u_xlat16_9.xyz) + u_xlat16_3.xxx;
    u_xlat38 = u_xlat27 * u_xlat27;
    u_xlat6.x = u_xlat38 * u_xlat38 + -1.0;
    u_xlat16 = u_xlat16 * u_xlat6.x + 1.00001001;
    u_xlat6.x = u_xlat27 * u_xlat27 + 1.5;
    u_xlat5.x = u_xlat5.x * u_xlat6.x;
    u_xlat5.x = u_xlat16 * u_xlat5.x;
    u_xlat5.x = u_xlat38 / u_xlat5.x;
    u_xlat16_37 = u_xlat27 * u_xlat38;
    u_xlat16_37 = (-u_xlat16_37) * 0.280000001 + 1.0;
    u_xlat5.x = u_xlat5.x + -9.99999975e-05;
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.x = min(u_xlat5.x, 100.0);
    u_xlat5.xyw = u_xlat5.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat5.xyw = u_xlat16_8.xyz * u_xlat5.xyw;
    u_xlat6.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat5.xyw = u_xlat5.xyw * u_xlat6.xxx + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat27<0.00499999989);
#else
    u_xlatb6 = u_xlat27<0.00499999989;
#endif
    u_xlat27 = u_xlat27 * 8.29800034;
    u_xlat16_2.x = (u_xlatb6) ? 0.0 : u_xlat27;
    u_xlat16_13 = dot((-u_xlat11.xyz), u_xlat1.xyz);
    u_xlat16_13 = u_xlat16_13 + u_xlat16_13;
    u_xlat16_8.xyz = u_xlat1.xyz * (-vec3(u_xlat16_13)) + (-u_xlat11.xyz);
    u_xlat11.x = dot(u_xlat1.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat11.x = min(max(u_xlat11.x, 0.0), 1.0);
#else
    u_xlat11.x = clamp(u_xlat11.x, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat11.x) + 1.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_3.xyw = vec3(u_xlat16_13) * u_xlat16_3.xyw + u_xlat16_9.xyz;
    u_xlat11.x = dot(u_xlat16_8.zxy, (-u_xlat16_8.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat11.x<9.99999975e-06);
#else
    u_xlatb11 = u_xlat11.x<9.99999975e-06;
#endif
    u_xlat11.x = (u_xlatb11) ? u_xlat16_8.z : (-u_xlat16_8.z);
    u_xlat6.z = u_xlat11.x * u_xlat16_8.x;
    u_xlat10.x = u_xlat11.x * u_xlat16_8.z;
    u_xlat6.xy = (-u_xlat16_8.xy) * u_xlat16_8.yz;
    u_xlat10.yz = (-u_xlat16_8.xy) * u_xlat16_8.xy;
    u_xlat11.xyz = u_xlat6.xyz + (-u_xlat10.xyz);
    u_xlat27 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat27);
    u_xlat11.xyz = u_xlat11.xyz * vec3(_NormalDiff);
    u_xlat0.xyz = u_xlat11.xyz * u_xlat0.xxx + u_xlat16_8.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_0.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = vec3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_37);
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyw + u_xlat5.xyw;
    u_xlat16_2.x = roundEven(u_xlat16_35);
    u_xlat16_13 = u_xlat16_35 * 2.0 + -1.0;
    u_xlat16_2.xzw = (-u_xlat16_4.xyz) * u_xlat16_25.xxx + u_xlat16_2.xxx;
    u_xlat16_2.xyz = abs(vec3(u_xlat16_13)) * u_xlat16_2.xzw + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
  Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 97766
Program "vp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.y = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat0.y;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.z = u_xlat0.z;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD3.y = u_xlat2.y;
    vs_TEXCOORD4.y = u_xlat2.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform highp sampler2D unity_NHxRoughness;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_11;
float u_xlat21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat21) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_4.xy = max(u_xlat16_3.xy, _MinMSA.xy);
    u_xlat16_23 = u_xlat16_3.z + -1.0;
    u_xlat16_23 = _Occlusion * u_xlat16_23 + 1.0;
    u_xlat16_23 = max(u_xlat16_23, _MinMSA.z);
    u_xlat0.y = (-u_xlat16_4.y) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_5.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_5.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat16_11.xy = u_xlat16_5.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_7.xyz = texture(_SphereMap, u_xlat16_11.xy).xyz;
    u_xlat16_11.xyz = u_xlat16_7.xyz * _SphereMapScale.xyz;
    u_xlat16_7.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz + _AddColor.xyz;
    u_xlat16_7.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_11.xyz = u_xlat16_11.xyz * u_xlat16_7.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_11.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_4.xxx * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_4.x = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_4.xxx * u_xlat16_11.xyz;
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_5.x = roundEven(u_xlat16_23);
    u_xlat16_23 = u_xlat16_23 * 2.0 + -1.0;
    u_xlat16_4.xyz = (-u_xlat16_11.xyz) * u_xlat16_4.xxx + u_xlat16_5.xxx;
    u_xlat16_4.xyz = abs(vec3(u_xlat16_23)) * u_xlat16_4.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.y = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat0.y;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.z = u_xlat0.z;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD3.y = u_xlat2.y;
    vs_TEXCOORD4.y = u_xlat2.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
vec3 u_xlat8;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_14;
mediump float u_xlat16_16;
float u_xlat21;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = max(u_xlat21, 0.00100000005);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat21 = max(u_xlat21, 0.319999993);
    u_xlat16_1.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_1.xy, _MinMSA.xy);
    u_xlat16_16 = u_xlat16_1.z + -1.0;
    u_xlat16_16 = _Occlusion * u_xlat16_16 + 1.0;
    u_xlat16_16 = max(u_xlat16_16, _MinMSA.z);
    u_xlat16_1.x = (-u_xlat16_2.y) + 1.0;
    u_xlat16_8.x = u_xlat16_1.x * u_xlat16_1.x + 1.5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat21 = u_xlat21 * u_xlat16_8.x;
    u_xlat16_8.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_8.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat16_3.xyz);
    u_xlat8.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat8.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7 = dot(u_xlat8.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_14 = u_xlat16_1.x * u_xlat16_1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_14 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat21;
    u_xlat0.x = u_xlat16_1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat16_9.xz = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xyz = texture(_SphereMap, u_xlat16_9.xz).xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * _SphereMapScale.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + _AddColor.xyz;
    u_xlat16_1.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat7) * u_xlat0.xzw;
    u_xlat16_9.x = roundEven(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * 2.0 + -1.0;
    u_xlat16_2.xyw = (-u_xlat16_3.xyz) * u_xlat16_2.xxx + u_xlat16_9.xxx;
    u_xlat16_2.xyz = abs(vec3(u_xlat16_16)) * u_xlat16_2.xyw + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD2.y = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat0.y;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.z = u_xlat0.z;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD3.y = u_xlat2.y;
    vs_TEXCOORD4.y = u_xlat2.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
vec3 u_xlat8;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_14;
mediump float u_xlat16_16;
float u_xlat21;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = max(u_xlat21, 0.00100000005);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat21 = max(u_xlat21, 0.319999993);
    u_xlat16_1.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_1.xy, _MinMSA.xy);
    u_xlat16_16 = u_xlat16_1.z + -1.0;
    u_xlat16_16 = _Occlusion * u_xlat16_16 + 1.0;
    u_xlat16_16 = max(u_xlat16_16, _MinMSA.z);
    u_xlat16_1.x = (-u_xlat16_2.y) + 1.0;
    u_xlat16_8.x = u_xlat16_1.x * u_xlat16_1.x + 1.5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat21 = u_xlat21 * u_xlat16_8.x;
    u_xlat16_8.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_8.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat16_3.xyz);
    u_xlat8.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat8.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7 = dot(u_xlat8.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_14 = u_xlat16_1.x * u_xlat16_1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_14 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat21;
    u_xlat0.x = u_xlat16_1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat16_9.xz = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xyz = texture(_SphereMap, u_xlat16_9.xz).xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * _SphereMapScale.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + _AddColor.xyz;
    u_xlat16_1.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat7) * u_xlat0.xzw;
    u_xlat16_9.x = roundEven(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * 2.0 + -1.0;
    u_xlat16_2.xyw = (-u_xlat16_3.xyz) * u_xlat16_2.xxx + u_xlat16_9.xxx;
    u_xlat16_2.xyz = abs(vec3(u_xlat16_16)) * u_xlat16_2.xyw + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD8 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat0.y;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.z = u_xlat0.z;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
uniform highp sampler2D unity_NHxRoughness;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_11;
float u_xlat21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_1.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.x = dot(vs_TEXCOORD2.xyz, u_xlat16_2.xyz);
    u_xlat1.y = dot(vs_TEXCOORD3.xyz, u_xlat16_2.xyz);
    u_xlat1.z = dot(vs_TEXCOORD4.xyz, u_xlat16_2.xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat1.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat3.xyz * (-vec3(u_xlat21)) + u_xlat0.xyz;
    u_xlat21 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat21) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_4.xy = max(u_xlat16_3.xy, _MinMSA.xy);
    u_xlat16_23 = u_xlat16_3.z + -1.0;
    u_xlat16_23 = _Occlusion * u_xlat16_23 + 1.0;
    u_xlat16_23 = max(u_xlat16_23, _MinMSA.z);
    u_xlat0.y = (-u_xlat16_4.y) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_5.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_5.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat16_11.xy = u_xlat16_5.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_7.xyz = texture(_SphereMap, u_xlat16_11.xy).xyz;
    u_xlat16_11.xyz = u_xlat16_7.xyz * _SphereMapScale.xyz;
    u_xlat16_7.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz + _AddColor.xyz;
    u_xlat16_7.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_11.xyz = u_xlat16_11.xyz * u_xlat16_7.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_11.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_4.xxx * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_4.x = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_4.xxx * u_xlat16_11.xyz;
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_5.x = roundEven(u_xlat16_23);
    u_xlat16_23 = u_xlat16_23 * 2.0 + -1.0;
    u_xlat16_4.xyz = (-u_xlat16_11.xyz) * u_xlat16_4.xxx + u_xlat16_5.xxx;
    u_xlat16_4.xyz = abs(vec3(u_xlat16_23)) * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    u_xlat0.x = vs_TEXCOORD8;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD8 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat0.y;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.z = u_xlat0.z;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
vec3 u_xlat8;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_14;
mediump float u_xlat16_16;
float u_xlat21;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = max(u_xlat21, 0.00100000005);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat21 = max(u_xlat21, 0.319999993);
    u_xlat16_1.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_1.xy, _MinMSA.xy);
    u_xlat16_16 = u_xlat16_1.z + -1.0;
    u_xlat16_16 = _Occlusion * u_xlat16_16 + 1.0;
    u_xlat16_16 = max(u_xlat16_16, _MinMSA.z);
    u_xlat16_1.x = (-u_xlat16_2.y) + 1.0;
    u_xlat16_8.x = u_xlat16_1.x * u_xlat16_1.x + 1.5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat21 = u_xlat21 * u_xlat16_8.x;
    u_xlat16_8.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_8.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat16_3.xyz);
    u_xlat8.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat8.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7 = dot(u_xlat8.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_14 = u_xlat16_1.x * u_xlat16_1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_14 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat21;
    u_xlat0.x = u_xlat16_1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat16_9.xz = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xyz = texture(_SphereMap, u_xlat16_9.xz).xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * _SphereMapScale.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + _AddColor.xyz;
    u_xlat16_1.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat7) * u_xlat0.xzw;
    u_xlat16_9.x = roundEven(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * 2.0 + -1.0;
    u_xlat16_2.xyw = (-u_xlat16_3.xyz) * u_xlat16_2.xxx + u_xlat16_9.xxx;
    u_xlat16_2.xyz = abs(vec3(u_xlat16_16)) * u_xlat16_2.xyw + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    u_xlat0.x = vs_TEXCOORD8;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _BumpMap_ST;
uniform 	vec4 _MSA_ST;
uniform 	vec4 _SphereMapMask_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp float vs_TEXCOORD8;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _SphereMapMask_ST.xy + _SphereMapMask_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD8 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
    vs_TEXCOORD2.y = u_xlat3.x;
    vs_TEXCOORD2.x = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat0.y;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD4.x = u_xlat1.y;
    vs_TEXCOORD3.z = u_xlat0.z;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD3.y = u_xlat3.y;
    vs_TEXCOORD4.y = u_xlat3.z;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _MinMSA;
uniform 	mediump vec4 _SphereMapScale;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D _BumpMap;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D _SphereMapMask;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp float vs_TEXCOORD8;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
vec3 u_xlat8;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_14;
mediump float u_xlat16_16;
float u_xlat21;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD5.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = max(u_xlat21, 0.00100000005);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat21 = max(u_xlat21, 0.319999993);
    u_xlat16_1.xyz = texture(_MSA, vs_TEXCOORD1.xy).xyz;
    u_xlat16_2.xy = max(u_xlat16_1.xy, _MinMSA.xy);
    u_xlat16_16 = u_xlat16_1.z + -1.0;
    u_xlat16_16 = _Occlusion * u_xlat16_16 + 1.0;
    u_xlat16_16 = max(u_xlat16_16, _MinMSA.z);
    u_xlat16_1.x = (-u_xlat16_2.y) + 1.0;
    u_xlat16_8.x = u_xlat16_1.x * u_xlat16_1.x + 1.5;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat21 = u_xlat21 * u_xlat16_8.x;
    u_xlat16_8.xyz = texture(_BumpMap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_8.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat4.x = dot(vs_TEXCOORD2.xyz, u_xlat16_3.xyz);
    u_xlat4.y = dot(vs_TEXCOORD3.xyz, u_xlat16_3.xyz);
    u_xlat4.z = dot(vs_TEXCOORD4.xyz, u_xlat16_3.xyz);
    u_xlat8.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat8.xyz = u_xlat8.xxx * u_xlat4.xyz;
    u_xlat0.x = dot(u_xlat8.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat7 = dot(u_xlat8.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_14 = u_xlat16_1.x * u_xlat16_1.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_14 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat21;
    u_xlat0.x = u_xlat16_1.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, u_xlat4.xyz);
    u_xlat16_9.xz = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xyz = texture(_SphereMap, u_xlat16_9.xz).xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * _SphereMapScale.xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + _AddColor.xyz;
    u_xlat16_1.xyz = texture(_SphereMapMask, vs_TEXCOORD1.zw).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_2.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat7) * u_xlat0.xzw;
    u_xlat16_9.x = roundEven(u_xlat16_16);
    u_xlat16_16 = u_xlat16_16 * 2.0 + -1.0;
    u_xlat16_2.xyw = (-u_xlat16_3.xyz) * u_xlat16_2.xxx + u_xlat16_9.xxx;
    u_xlat16_2.xyz = abs(vec3(u_xlat16_16)) * u_xlat16_2.xyw + u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    u_xlat0.x = vs_TEXCOORD8;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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