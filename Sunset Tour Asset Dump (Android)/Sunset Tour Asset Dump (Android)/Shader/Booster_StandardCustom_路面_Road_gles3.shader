//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/StandardCustom/路面/Road" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_Metallic ("Metallic", Range(0, 1)) = 0
_Smoothness ("Smoothness", Range(0, 1)) = 0
_Occlusion ("Occlusion", Range(0, 1)) = 1
[Space(20)] _CameraNearColorMaxDistance ("Camera Near Fog Max Distance", Range(0.001, 100)) = 0.1
_CameraNearColor ("Camera Near Color", Color) = (1,1,1,1)
_CameraNearColorUVScale ("Camera near Color Fog UV Scale", Vector) = (1,1,1,1)
_CameraNearFogMap ("Camera Near Colormap(UV0)", 2D) = "white" { }
[Header(Booster Reflection Cube Map)] [KeywordEnum(NO,YES,FIXEDCOLOR)] _ReflectionProbeType ("個別リフレクションキューブマップ使用", Float) = 0
_HeuristicReflection ("個別リフレクションキューブマップ", Cube) = "_Skybox" { }
_NormalDiff ("疑似LOD反射の揺らぎ", Range(-1, 1)) = 0
_NormalRand ("疑似LOD乱数値", Vector) = (9993.169,5715.817,4488.509,34.2347)
_FixedReflColor ("単色リフレクションカラー", Color) = (1,1,1,1)
[Space(20)] [Enum(NO,0,YES,128)] _StencilOp ("置き影が落ちなくなる", Float) = 0
}
SubShader {
 LOD 5000
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 5000
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
  GpuProgramID 33142
Program "vp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
vec2 u_xlat16;
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
    u_xlat16_28 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlat16_28 = u_xlat16_28 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_28) * _CameraNearColor.xyz;
    u_xlat16.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_2.xyz = texture(_CameraNearFogMap, u_xlat16.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    u_xlat16_2.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_29 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_29 = u_xlat16_29 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_29);
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat0.xxx * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz * vec3(u_xlat16_28) + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
float u_xlat16;
float u_xlat24;
float u_xlat27;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat9.xyz = u_xlat8.xyz * vec3(u_xlat1);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat9.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat9.xyz);
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
    u_xlat27 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat27;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_29 = u_xlat0.x * u_xlat1;
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
    u_xlat16_6.x = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = u_xlat16_6.x / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xxx * _CameraNearColor.xyz;
    u_xlat9.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_9.xyz = texture(_CameraNearFogMap, u_xlat9.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_6.xyz;
    u_xlat16_9.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_9.xyz;
    u_xlat16_6.xyz = u_xlat16_9.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_30 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.x = (-u_xlat16_30) + _Smoothness;
    u_xlat16_7.x = u_xlat16_7.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_7.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
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
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat8.x = u_xlat8.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = u_xlat16_6.xyz * u_xlat0.xxx;
    u_xlat0.xyw = u_xlat16_9.xyz * vec3(u_xlat16_30) + u_xlat0.xyw;
    u_xlat0.xyw = u_xlat0.xyw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * vec3(u_xlat16) + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
float u_xlat16;
float u_xlat24;
float u_xlat27;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat9.xyz = u_xlat8.xyz * vec3(u_xlat1);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat9.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat9.xyz);
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
    u_xlat27 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat27;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_29 = u_xlat0.x * u_xlat1;
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
    u_xlat16_6.x = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = u_xlat16_6.x / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xxx * _CameraNearColor.xyz;
    u_xlat9.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_9.xyz = texture(_CameraNearFogMap, u_xlat9.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_6.xyz;
    u_xlat16_9.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_9.xyz;
    u_xlat16_6.xyz = u_xlat16_9.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_30 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.x = (-u_xlat16_30) + _Smoothness;
    u_xlat16_7.x = u_xlat16_7.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_7.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
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
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat8.x = u_xlat8.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = u_xlat16_6.xyz * u_xlat0.xxx;
    u_xlat0.xyw = u_xlat16_9.xyz * vec3(u_xlat16_30) + u_xlat0.xyw;
    u_xlat0.xyw = u_xlat0.xyw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * vec3(u_xlat16) + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_3 = u_xlat1.y * u_xlat1.y;
    u_xlat16_3 = u_xlat1.x * u_xlat1.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
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
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
vec2 u_xlat20;
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
    u_xlat16_31 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_31 = max(u_xlat16_31, 0.0);
    u_xlat16_31 = u_xlat16_31 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = vec3(u_xlat16_31) * _CameraNearColor.xyz;
    u_xlat20.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_3.xyz = texture(_CameraNearFogMap, u_xlat20.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_7.xyz;
    u_xlat16_3.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_3.xyz;
    u_xlat16_7.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_31 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_35 = (-u_xlat16_31) + _Smoothness;
    u_xlat16_8.xyz = vec3(u_xlat16_31) * u_xlat16_3.xyz;
    u_xlat16_31 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_31);
    u_xlat16_9.xyz = vec3(u_xlat16_10) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_1.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_3 = u_xlat1.y * u_xlat1.y;
    u_xlat16_3 = u_xlat1.x * u_xlat1.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
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
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_35 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_35 = max(u_xlat16_35, 0.0);
    u_xlat16_35 = u_xlat16_35 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_35) * _CameraNearColor.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_10.xyz = texture(_CameraNearFogMap, u_xlat10.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_6.xyz;
    u_xlat16_10.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_10.xyz;
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
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD4.xyz;
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
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_3 = u_xlat1.y * u_xlat1.y;
    u_xlat16_3 = u_xlat1.x * u_xlat1.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
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
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_35 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_35 = max(u_xlat16_35, 0.0);
    u_xlat16_35 = u_xlat16_35 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_35) * _CameraNearColor.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_10.xyz = texture(_CameraNearFogMap, u_xlat10.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_6.xyz;
    u_xlat16_10.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_10.xyz;
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
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD4.xyz;
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
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_3 = u_xlat1.y * u_xlat1.y;
    u_xlat16_3 = u_xlat1.x * u_xlat1.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
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
    u_xlat16_28 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlat16_28 = u_xlat16_28 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_28) * _CameraNearColor.xyz;
    u_xlat3.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_3.xyz = texture(_CameraNearFogMap, u_xlat3.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_6.xyz;
    u_xlat16_3.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_3.xyz;
    u_xlat16_28 = u_xlat16_32 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_28);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat16_5.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_28 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_28) * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_1.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_3 = u_xlat1.y * u_xlat1.y;
    u_xlat16_3 = u_xlat1.x * u_xlat1.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
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
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_35 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_35 = max(u_xlat16_35, 0.0);
    u_xlat16_35 = u_xlat16_35 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_35) * _CameraNearColor.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_10.xyz = texture(_CameraNearFogMap, u_xlat10.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_6.xyz;
    u_xlat16_10.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_10.xyz;
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
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
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
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD4.xyz;
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
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_3 = u_xlat1.y * u_xlat1.y;
    u_xlat16_3 = u_xlat1.x * u_xlat1.x + (-u_xlat16_3);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_3) + u_xlat16_4.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
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
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_35 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_35 = max(u_xlat16_35, 0.0);
    u_xlat16_35 = u_xlat16_35 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_35) * _CameraNearColor.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_10.xyz = texture(_CameraNearFogMap, u_xlat10.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_6.xyz;
    u_xlat16_10.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_10.xyz;
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
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
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
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD4.xyz;
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
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
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
vec2 u_xlat18;
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
    u_xlat16_31 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_31 = max(u_xlat16_31, 0.0);
    u_xlat16_31 = u_xlat16_31 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_31) * _CameraNearColor.xyz;
    u_xlat18.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_2.xyz = texture(_CameraNearFogMap, u_xlat18.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    u_xlat16_2.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_31 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_31) + _Smoothness;
    u_xlat16_7.xyz = u_xlat16_2.xyz * vec3(u_xlat16_31);
    u_xlat16_31 = u_xlat16_32 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_31);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_8.xyz * u_xlat16_7.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
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
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_35 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_35 = max(u_xlat16_35, 0.0);
    u_xlat16_35 = u_xlat16_35 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_35) * _CameraNearColor.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_10.xyz = texture(_CameraNearFogMap, u_xlat10.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_6.xyz;
    u_xlat16_10.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_10.xyz;
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
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
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
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_35 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_35 = max(u_xlat16_35, 0.0);
    u_xlat16_35 = u_xlat16_35 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_35) * _CameraNearColor.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_10.xyz = texture(_CameraNearFogMap, u_xlat10.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_6.xyz;
    u_xlat16_10.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_10.xyz;
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
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
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
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_13;
vec2 u_xlat23;
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
    u_xlat16_30 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_30 = max(u_xlat16_30, 0.0);
    u_xlat16_30 = u_xlat16_30 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = vec3(u_xlat16_30) * _CameraNearColor.xyz;
    u_xlat23.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_4.xyz = texture(_CameraNearFogMap, u_xlat23.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_4.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_30 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_30) + _Smoothness;
    u_xlat16_8.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_30 = u_xlat16_32 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_30);
    u_xlat16_9.xyz = vec3(u_xlat16_13) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat3.xxx * u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_9.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_8.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_0.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump float u_xlat16_8;
float u_xlat12;
float u_xlat20;
mediump float u_xlat16_24;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
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
    u_xlat16_24 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_24 = u_xlat16_24 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_24) * _CameraNearColor.xyz;
    u_xlat3.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_3.xyz = texture(_CameraNearFogMap, u_xlat3.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_3.xyz;
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_24 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_24 = u_xlat16_24 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = (-u_xlat16_5.xyz) + vec3(u_xlat16_24);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 0.319999993);
    u_xlat28 = (-_Smoothness) + 1.0;
    u_xlat7.x = u_xlat28 * u_xlat28 + 1.5;
    u_xlat27 = u_xlat27 * u_xlat7.x;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat7.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat12 = u_xlat28 * u_xlat28;
    u_xlat20 = u_xlat12 * u_xlat12 + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat20 + 1.00001001;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat27 = u_xlat12 / u_xlat27;
    u_xlat16_24 = u_xlat28 * u_xlat12;
    u_xlat16_24 = (-u_xlat16_24) * 0.280000001 + 1.0;
    u_xlat27 = u_xlat27 + -9.99999975e-05;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 100.0);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _LightColor0.xyz;
    u_xlat27 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat7.x = dot(u_xlat7.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat7.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat28<0.00499999989);
#else
    u_xlatb27 = u_xlat28<0.00499999989;
#endif
    u_xlat28 = u_xlat28 * 8.29800034;
    u_xlat16_0.x = (u_xlatb27) ? 0.0 : u_xlat28;
    u_xlat16_8 = dot((-u_xlat3.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_8 = u_xlat16_8 + u_xlat16_8;
    u_xlat16_5.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_8)) + (-u_xlat3.xyz);
    u_xlat3.x = dot(u_xlat16_5.zxy, (-u_xlat16_5.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<9.99999975e-06);
#else
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
#endif
    u_xlat3.x = (u_xlatb3) ? u_xlat16_5.z : (-u_xlat16_5.z);
    u_xlat7.z = u_xlat3.x * u_xlat16_5.x;
    u_xlat3.x = u_xlat3.x * u_xlat16_5.z;
    u_xlat7.xy = (-u_xlat16_5.xy) * u_xlat16_5.yz;
    u_xlat3.yz = (-u_xlat16_5.xy) * u_xlat16_5.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat7.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat27 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat16_5.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_24);
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump float u_xlat16_8;
float u_xlat12;
float u_xlat20;
mediump float u_xlat16_24;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
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
    u_xlat16_24 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_24 = u_xlat16_24 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_24) * _CameraNearColor.xyz;
    u_xlat3.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_3.xyz = texture(_CameraNearFogMap, u_xlat3.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_3.xyz;
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_24 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_24 = u_xlat16_24 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = (-u_xlat16_5.xyz) + vec3(u_xlat16_24);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 0.319999993);
    u_xlat28 = (-_Smoothness) + 1.0;
    u_xlat7.x = u_xlat28 * u_xlat28 + 1.5;
    u_xlat27 = u_xlat27 * u_xlat7.x;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat7.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat12 = u_xlat28 * u_xlat28;
    u_xlat20 = u_xlat12 * u_xlat12 + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat20 + 1.00001001;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat27 = u_xlat12 / u_xlat27;
    u_xlat16_24 = u_xlat28 * u_xlat12;
    u_xlat16_24 = (-u_xlat16_24) * 0.280000001 + 1.0;
    u_xlat27 = u_xlat27 + -9.99999975e-05;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 100.0);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _LightColor0.xyz;
    u_xlat27 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat7.x = dot(u_xlat7.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat7.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat28<0.00499999989);
#else
    u_xlatb27 = u_xlat28<0.00499999989;
#endif
    u_xlat28 = u_xlat28 * 8.29800034;
    u_xlat16_0.x = (u_xlatb27) ? 0.0 : u_xlat28;
    u_xlat16_8 = dot((-u_xlat3.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_8 = u_xlat16_8 + u_xlat16_8;
    u_xlat16_5.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_8)) + (-u_xlat3.xyz);
    u_xlat3.x = dot(u_xlat16_5.zxy, (-u_xlat16_5.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<9.99999975e-06);
#else
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
#endif
    u_xlat3.x = (u_xlatb3) ? u_xlat16_5.z : (-u_xlat16_5.z);
    u_xlat7.z = u_xlat3.x * u_xlat16_5.x;
    u_xlat3.x = u_xlat3.x * u_xlat16_5.z;
    u_xlat7.xy = (-u_xlat16_5.xy) * u_xlat16_5.yz;
    u_xlat3.yz = (-u_xlat16_5.xy) * u_xlat16_5.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat7.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat27 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat16_5.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_24);
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
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
    u_xlat16_28 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlat16_28 = u_xlat16_28 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_28) * _CameraNearColor.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_2.xyz = texture(_CameraNearFogMap, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_29 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_6.xyz = u_xlat16_2.xyz * vec3(u_xlat16_28);
    u_xlat16_28 = u_xlat16_29 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + vec3(u_xlat16_28);
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_28 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_28) * _LightColor0.xyz;
    u_xlat16_6.xyz = vec3(u_xlat24) * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat16_4.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
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
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_35 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_35 = max(u_xlat16_35, 0.0);
    u_xlat16_35 = u_xlat16_35 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_35) * _CameraNearColor.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_10.xyz = texture(_CameraNearFogMap, u_xlat10.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_6.xyz;
    u_xlat16_10.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_10.xyz;
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
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_35 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
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
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_35 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_35 = max(u_xlat16_35, 0.0);
    u_xlat16_35 = u_xlat16_35 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_35) * _CameraNearColor.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_10.xyz = texture(_CameraNearFogMap, u_xlat10.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_6.xyz;
    u_xlat16_10.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_10.xyz;
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
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_35 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
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
    u_xlat16_27 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_27 = max(u_xlat16_27, 0.0);
    u_xlat16_27 = u_xlat16_27 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_27) * _CameraNearColor.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_4.xyz = texture(_CameraNearFogMap, u_xlat4.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz;
    u_xlat16_4.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_4.xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_27 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_29 = (-u_xlat16_27) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz;
    u_xlat16_27 = u_xlat16_29 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_27);
    u_xlat16_8.xyz = vec3(u_xlat16_12) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat3.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz + u_xlat16_2.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_27 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_27) * _LightColor0.xyz;
    u_xlat16_2.xyz = vec3(u_xlat30) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_2.xyz + u_xlat16_0.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump float u_xlat16_8;
float u_xlat12;
float u_xlat20;
mediump float u_xlat16_24;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
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
    u_xlat16_24 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_24 = u_xlat16_24 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_24) * _CameraNearColor.xyz;
    u_xlat3.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_3.xyz = texture(_CameraNearFogMap, u_xlat3.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_3.xyz;
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_24 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_24 = u_xlat16_24 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = (-u_xlat16_5.xyz) + vec3(u_xlat16_24);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 0.319999993);
    u_xlat28 = (-_Smoothness) + 1.0;
    u_xlat7.x = u_xlat28 * u_xlat28 + 1.5;
    u_xlat27 = u_xlat27 * u_xlat7.x;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat7.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat12 = u_xlat28 * u_xlat28;
    u_xlat20 = u_xlat12 * u_xlat12 + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat20 + 1.00001001;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat27 = u_xlat12 / u_xlat27;
    u_xlat16_24 = u_xlat28 * u_xlat12;
    u_xlat16_24 = (-u_xlat16_24) * 0.280000001 + 1.0;
    u_xlat27 = u_xlat27 + -9.99999975e-05;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 100.0);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_2.x = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
    u_xlat4.xyz = u_xlat16_2.xyz * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat7.x = dot(u_xlat7.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat7.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat28<0.00499999989);
#else
    u_xlatb27 = u_xlat28<0.00499999989;
#endif
    u_xlat28 = u_xlat28 * 8.29800034;
    u_xlat16_0.x = (u_xlatb27) ? 0.0 : u_xlat28;
    u_xlat16_8 = dot((-u_xlat3.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_8 = u_xlat16_8 + u_xlat16_8;
    u_xlat16_5.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_8)) + (-u_xlat3.xyz);
    u_xlat3.x = dot(u_xlat16_5.zxy, (-u_xlat16_5.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<9.99999975e-06);
#else
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
#endif
    u_xlat3.x = (u_xlatb3) ? u_xlat16_5.z : (-u_xlat16_5.z);
    u_xlat7.z = u_xlat3.x * u_xlat16_5.x;
    u_xlat3.x = u_xlat3.x * u_xlat16_5.z;
    u_xlat7.xy = (-u_xlat16_5.xy) * u_xlat16_5.yz;
    u_xlat3.yz = (-u_xlat16_5.xy) * u_xlat16_5.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat7.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat27 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat16_5.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_24);
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump float u_xlat16_8;
float u_xlat12;
float u_xlat20;
mediump float u_xlat16_24;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
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
    u_xlat16_24 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_24 = u_xlat16_24 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_24) * _CameraNearColor.xyz;
    u_xlat3.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_3.xyz = texture(_CameraNearFogMap, u_xlat3.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_3.xyz;
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_24 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_24 = u_xlat16_24 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = (-u_xlat16_5.xyz) + vec3(u_xlat16_24);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 0.319999993);
    u_xlat28 = (-_Smoothness) + 1.0;
    u_xlat7.x = u_xlat28 * u_xlat28 + 1.5;
    u_xlat27 = u_xlat27 * u_xlat7.x;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat7.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat12 = u_xlat28 * u_xlat28;
    u_xlat20 = u_xlat12 * u_xlat12 + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat20 + 1.00001001;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat27 = u_xlat12 / u_xlat27;
    u_xlat16_24 = u_xlat28 * u_xlat12;
    u_xlat16_24 = (-u_xlat16_24) * 0.280000001 + 1.0;
    u_xlat27 = u_xlat27 + -9.99999975e-05;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 100.0);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_2.x = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
    u_xlat4.xyz = u_xlat16_2.xyz * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat7.x = dot(u_xlat7.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat7.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat28<0.00499999989);
#else
    u_xlatb27 = u_xlat28<0.00499999989;
#endif
    u_xlat28 = u_xlat28 * 8.29800034;
    u_xlat16_0.x = (u_xlatb27) ? 0.0 : u_xlat28;
    u_xlat16_8 = dot((-u_xlat3.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_8 = u_xlat16_8 + u_xlat16_8;
    u_xlat16_5.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_8)) + (-u_xlat3.xyz);
    u_xlat3.x = dot(u_xlat16_5.zxy, (-u_xlat16_5.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<9.99999975e-06);
#else
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
#endif
    u_xlat3.x = (u_xlatb3) ? u_xlat16_5.z : (-u_xlat16_5.z);
    u_xlat7.z = u_xlat3.x * u_xlat16_5.x;
    u_xlat3.x = u_xlat3.x * u_xlat16_5.z;
    u_xlat7.xy = (-u_xlat16_5.xy) * u_xlat16_5.yz;
    u_xlat3.yz = (-u_xlat16_5.xy) * u_xlat16_5.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat7.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat27 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat16_5.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_24);
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
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
vec2 u_xlat16;
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
    u_xlat16_28 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlat16_28 = u_xlat16_28 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_28) * _CameraNearColor.xyz;
    u_xlat16.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_2.xyz = texture(_CameraNearFogMap, u_xlat16.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    u_xlat16_2.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_29 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_29 = u_xlat16_29 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_29);
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat0.xxx * u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz * vec3(u_xlat16_28) + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat16_0.xyz + unity_FogColor.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
float u_xlat16;
float u_xlat24;
float u_xlat27;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat9.xyz = u_xlat8.xyz * vec3(u_xlat1);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat9.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat9.xyz);
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
    u_xlat27 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat27;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_29 = u_xlat0.x * u_xlat1;
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
    u_xlat16_6.x = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = u_xlat16_6.x / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xxx * _CameraNearColor.xyz;
    u_xlat9.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_9.xyz = texture(_CameraNearFogMap, u_xlat9.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_6.xyz;
    u_xlat16_9.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_9.xyz;
    u_xlat16_6.xyz = u_xlat16_9.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_30 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.x = (-u_xlat16_30) + _Smoothness;
    u_xlat16_7.x = u_xlat16_7.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_7.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
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
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat8.x = u_xlat8.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = u_xlat16_6.xyz * u_xlat0.xxx;
    u_xlat0.xyw = u_xlat16_9.xyz * vec3(u_xlat16_30) + u_xlat0.xyw;
    u_xlat0.xyw = u_xlat0.xyw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * vec3(u_xlat16) + u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz + unity_FogColor.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
float u_xlat16;
float u_xlat24;
float u_xlat27;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat9.xyz = u_xlat8.xyz * vec3(u_xlat1);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat9.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat9.xyz);
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
    u_xlat27 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat27;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_29 = u_xlat0.x * u_xlat1;
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
    u_xlat16_6.x = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = u_xlat16_6.x / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = u_xlat16_6.xxx * _CameraNearColor.xyz;
    u_xlat9.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_9.xyz = texture(_CameraNearFogMap, u_xlat9.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_6.xyz;
    u_xlat16_9.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_9.xyz;
    u_xlat16_6.xyz = u_xlat16_9.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_30 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_7.x = (-u_xlat16_30) + _Smoothness;
    u_xlat16_7.x = u_xlat16_7.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = (-u_xlat16_6.xyz) + u_xlat16_7.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
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
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat8.x = u_xlat8.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = u_xlat16_6.xyz * u_xlat0.xxx;
    u_xlat0.xyw = u_xlat16_9.xyz * vec3(u_xlat16_30) + u_xlat0.xyw;
    u_xlat0.xyw = u_xlat0.xyw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * vec3(u_xlat16) + u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz + unity_FogColor.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat1.y * u_xlat1.y;
    u_xlat16_2 = u_xlat1.x * u_xlat1.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_4.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
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
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
vec2 u_xlat20;
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
    u_xlat16_31 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_31 = max(u_xlat16_31, 0.0);
    u_xlat16_31 = u_xlat16_31 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = vec3(u_xlat16_31) * _CameraNearColor.xyz;
    u_xlat20.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_3.xyz = texture(_CameraNearFogMap, u_xlat20.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_7.xyz;
    u_xlat16_3.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_3.xyz;
    u_xlat16_7.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_31 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_35 = (-u_xlat16_31) + _Smoothness;
    u_xlat16_8.xyz = vec3(u_xlat16_31) * u_xlat16_3.xyz;
    u_xlat16_31 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_31);
    u_xlat16_9.xyz = vec3(u_xlat16_10) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_8.xyz + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat16_0.xyz + unity_FogColor.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat1.y * u_xlat1.y;
    u_xlat16_2 = u_xlat1.x * u_xlat1.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_4.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
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
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_35 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_35 = max(u_xlat16_35, 0.0);
    u_xlat16_35 = u_xlat16_35 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_35) * _CameraNearColor.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_10.xyz = texture(_CameraNearFogMap, u_xlat10.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_6.xyz;
    u_xlat16_10.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_10.xyz;
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
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD4.xyz;
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
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD5;
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
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat1.y * u_xlat1.y;
    u_xlat16_2 = u_xlat1.x * u_xlat1.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_4.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
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
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_35 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_35 = max(u_xlat16_35, 0.0);
    u_xlat16_35 = u_xlat16_35 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_35) * _CameraNearColor.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_10.xyz = texture(_CameraNearFogMap, u_xlat10.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_6.xyz;
    u_xlat16_10.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_10.xyz;
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
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD4.xyz;
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
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD5;
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
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
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
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat1.y * u_xlat1.y;
    u_xlat16_2 = u_xlat1.x * u_xlat1.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_4.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
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
    u_xlat16_28 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlat16_28 = u_xlat16_28 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_28) * _CameraNearColor.xyz;
    u_xlat3.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_3.xyz = texture(_CameraNearFogMap, u_xlat3.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_6.xyz;
    u_xlat16_3.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_3.xyz;
    u_xlat16_6.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_28) * u_xlat16_3.xyz;
    u_xlat16_28 = u_xlat16_32 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_28);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat16_5.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
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
    u_xlat27 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + unity_FogColor.xyz;
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

uniform 	vec4 _ProjectionParams;
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
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat1.y * u_xlat1.y;
    u_xlat16_2 = u_xlat1.x * u_xlat1.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_4.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
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
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_35 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_35 = max(u_xlat16_35, 0.0);
    u_xlat16_35 = u_xlat16_35 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_35) * _CameraNearColor.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_10.xyz = texture(_CameraNearFogMap, u_xlat10.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_6.xyz;
    u_xlat16_10.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_10.xyz;
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
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
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
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD4.xyz;
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
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD5;
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

uniform 	vec4 _ProjectionParams;
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
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_4;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat3.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat3.zz + u_xlat3.xw;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat1.y * u_xlat1.y;
    u_xlat16_2 = u_xlat1.x * u_xlat1.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat16_4.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_4.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_4.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_4.xyz;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
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
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_35 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_35 = max(u_xlat16_35, 0.0);
    u_xlat16_35 = u_xlat16_35 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_35) * _CameraNearColor.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_10.xyz = texture(_CameraNearFogMap, u_xlat10.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_6.xyz;
    u_xlat16_10.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_10.xyz;
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
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
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
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD4.xyz;
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
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD5;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
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
vec2 u_xlat18;
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
    u_xlat16_31 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_31 = max(u_xlat16_31, 0.0);
    u_xlat16_31 = u_xlat16_31 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_31) * _CameraNearColor.xyz;
    u_xlat18.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_2.xyz = texture(_CameraNearFogMap, u_xlat18.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    u_xlat16_2.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_2.xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_31 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_31) + _Smoothness;
    u_xlat16_7.xyz = u_xlat16_2.xyz * vec3(u_xlat16_31);
    u_xlat16_31 = u_xlat16_32 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_31);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_8.xyz * u_xlat16_7.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + unity_FogColor.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
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
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_35 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_35 = max(u_xlat16_35, 0.0);
    u_xlat16_35 = u_xlat16_35 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_35) * _CameraNearColor.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_10.xyz = texture(_CameraNearFogMap, u_xlat10.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_6.xyz;
    u_xlat16_10.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_10.xyz;
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
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD5;
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
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
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_35 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_35 = max(u_xlat16_35, 0.0);
    u_xlat16_35 = u_xlat16_35 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_35) * _CameraNearColor.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_10.xyz = texture(_CameraNearFogMap, u_xlat10.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_6.xyz;
    u_xlat16_10.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_10.xyz;
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
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD5;
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
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
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_13;
vec2 u_xlat23;
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
    u_xlat16_30 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_30 = max(u_xlat16_30, 0.0);
    u_xlat16_30 = u_xlat16_30 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = vec3(u_xlat16_30) * _CameraNearColor.xyz;
    u_xlat23.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_4.xyz = texture(_CameraNearFogMap, u_xlat23.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_4.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_30 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_30) + _Smoothness;
    u_xlat16_8.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_30 = u_xlat16_32 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_30);
    u_xlat16_9.xyz = vec3(u_xlat16_13) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat3.xxx * u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_9.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat33) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump float u_xlat16_8;
float u_xlat12;
float u_xlat20;
mediump float u_xlat16_24;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
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
    u_xlat16_24 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_24 = u_xlat16_24 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_24) * _CameraNearColor.xyz;
    u_xlat3.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_3.xyz = texture(_CameraNearFogMap, u_xlat3.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_3.xyz;
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_24 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_24 = u_xlat16_24 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = (-u_xlat16_5.xyz) + vec3(u_xlat16_24);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 0.319999993);
    u_xlat28 = (-_Smoothness) + 1.0;
    u_xlat7.x = u_xlat28 * u_xlat28 + 1.5;
    u_xlat27 = u_xlat27 * u_xlat7.x;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat7.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat12 = u_xlat28 * u_xlat28;
    u_xlat20 = u_xlat12 * u_xlat12 + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat20 + 1.00001001;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat27 = u_xlat12 / u_xlat27;
    u_xlat16_24 = u_xlat28 * u_xlat12;
    u_xlat16_24 = (-u_xlat16_24) * 0.280000001 + 1.0;
    u_xlat27 = u_xlat27 + -9.99999975e-05;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 100.0);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _LightColor0.xyz;
    u_xlat27 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat7.x = dot(u_xlat7.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat7.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat28<0.00499999989);
#else
    u_xlatb27 = u_xlat28<0.00499999989;
#endif
    u_xlat28 = u_xlat28 * 8.29800034;
    u_xlat16_0.x = (u_xlatb27) ? 0.0 : u_xlat28;
    u_xlat16_8 = dot((-u_xlat3.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_8 = u_xlat16_8 + u_xlat16_8;
    u_xlat16_5.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_8)) + (-u_xlat3.xyz);
    u_xlat3.x = dot(u_xlat16_5.zxy, (-u_xlat16_5.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<9.99999975e-06);
#else
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
#endif
    u_xlat3.x = (u_xlatb3) ? u_xlat16_5.z : (-u_xlat16_5.z);
    u_xlat7.z = u_xlat3.x * u_xlat16_5.x;
    u_xlat3.x = u_xlat3.x * u_xlat16_5.z;
    u_xlat7.xy = (-u_xlat16_5.xy) * u_xlat16_5.yz;
    u_xlat3.yz = (-u_xlat16_5.xy) * u_xlat16_5.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat7.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat27 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat16_5.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_24);
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump float u_xlat16_8;
float u_xlat12;
float u_xlat20;
mediump float u_xlat16_24;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
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
    u_xlat16_24 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_24 = u_xlat16_24 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_24) * _CameraNearColor.xyz;
    u_xlat3.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_3.xyz = texture(_CameraNearFogMap, u_xlat3.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_3.xyz;
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_24 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_24 = u_xlat16_24 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = (-u_xlat16_5.xyz) + vec3(u_xlat16_24);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 0.319999993);
    u_xlat28 = (-_Smoothness) + 1.0;
    u_xlat7.x = u_xlat28 * u_xlat28 + 1.5;
    u_xlat27 = u_xlat27 * u_xlat7.x;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat7.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat12 = u_xlat28 * u_xlat28;
    u_xlat20 = u_xlat12 * u_xlat12 + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat20 + 1.00001001;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat27 = u_xlat12 / u_xlat27;
    u_xlat16_24 = u_xlat28 * u_xlat12;
    u_xlat16_24 = (-u_xlat16_24) * 0.280000001 + 1.0;
    u_xlat27 = u_xlat27 + -9.99999975e-05;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 100.0);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _LightColor0.xyz;
    u_xlat27 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat7.x = dot(u_xlat7.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat7.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat28<0.00499999989);
#else
    u_xlatb27 = u_xlat28<0.00499999989;
#endif
    u_xlat28 = u_xlat28 * 8.29800034;
    u_xlat16_0.x = (u_xlatb27) ? 0.0 : u_xlat28;
    u_xlat16_8 = dot((-u_xlat3.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_8 = u_xlat16_8 + u_xlat16_8;
    u_xlat16_5.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_8)) + (-u_xlat3.xyz);
    u_xlat3.x = dot(u_xlat16_5.zxy, (-u_xlat16_5.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<9.99999975e-06);
#else
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
#endif
    u_xlat3.x = (u_xlatb3) ? u_xlat16_5.z : (-u_xlat16_5.z);
    u_xlat7.z = u_xlat3.x * u_xlat16_5.x;
    u_xlat3.x = u_xlat3.x * u_xlat16_5.z;
    u_xlat7.xy = (-u_xlat16_5.xy) * u_xlat16_5.yz;
    u_xlat3.yz = (-u_xlat16_5.xy) * u_xlat16_5.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat7.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat27 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat16_5.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_24);
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
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
    u_xlat16_28 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_28 = max(u_xlat16_28, 0.0);
    u_xlat16_28 = u_xlat16_28 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_28) * _CameraNearColor.xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_2.xyz = texture(_CameraNearFogMap, u_xlat2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_2.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_28 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_29 = (-u_xlat16_28) + _Smoothness;
    u_xlat16_6.xyz = u_xlat16_2.xyz * vec3(u_xlat16_28);
    u_xlat16_28 = u_xlat16_29 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + vec3(u_xlat16_28);
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
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
    u_xlat24 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat16_0.xyz + unity_FogColor.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
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
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_35 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_35 = max(u_xlat16_35, 0.0);
    u_xlat16_35 = u_xlat16_35 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_35) * _CameraNearColor.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_10.xyz = texture(_CameraNearFogMap, u_xlat10.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_6.xyz;
    u_xlat16_10.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_10.xyz;
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
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_35 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD5;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
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
    u_xlat20 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat10.x = u_xlat10.x * u_xlat20 + 1.00001001;
    u_xlat0.x = u_xlat10.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_35 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_35 = max(u_xlat16_35, 0.0);
    u_xlat16_35 = u_xlat16_35 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_35) * _CameraNearColor.xyz;
    u_xlat10.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_10.xyz = texture(_CameraNearFogMap, u_xlat10.xy).xyz;
    u_xlat16_10.xyz = u_xlat16_10.xyz * u_xlat16_6.xyz;
    u_xlat16_10.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_10.xyz;
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
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_35 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD4.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_7.xyz = u_xlat16_7.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_35 = (-u_xlat1) + 1.0;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_35 = u_xlat16_35 * u_xlat16_35;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD5;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
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
    u_xlat16_27 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_27 = max(u_xlat16_27, 0.0);
    u_xlat16_27 = u_xlat16_27 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_27) * _CameraNearColor.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_4.xyz = texture(_CameraNearFogMap, u_xlat4.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz;
    u_xlat16_4.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_4.xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_27 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_29 = (-u_xlat16_27) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz;
    u_xlat16_27 = u_xlat16_29 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_27);
    u_xlat16_8.xyz = vec3(u_xlat16_12) * u_xlat16_8.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat3.xxx * u_xlat16_6.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz + u_xlat16_2.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
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
    u_xlat30 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump float u_xlat16_8;
float u_xlat12;
float u_xlat20;
mediump float u_xlat16_24;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
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
    u_xlat16_24 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_24 = u_xlat16_24 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_24) * _CameraNearColor.xyz;
    u_xlat3.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_3.xyz = texture(_CameraNearFogMap, u_xlat3.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_3.xyz;
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_24 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_24 = u_xlat16_24 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = (-u_xlat16_5.xyz) + vec3(u_xlat16_24);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 0.319999993);
    u_xlat28 = (-_Smoothness) + 1.0;
    u_xlat7.x = u_xlat28 * u_xlat28 + 1.5;
    u_xlat27 = u_xlat27 * u_xlat7.x;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat7.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat12 = u_xlat28 * u_xlat28;
    u_xlat20 = u_xlat12 * u_xlat12 + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat20 + 1.00001001;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat27 = u_xlat12 / u_xlat27;
    u_xlat16_24 = u_xlat28 * u_xlat12;
    u_xlat16_24 = (-u_xlat16_24) * 0.280000001 + 1.0;
    u_xlat27 = u_xlat27 + -9.99999975e-05;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 100.0);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_2.x = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
    u_xlat4.xyz = u_xlat16_2.xyz * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat7.x = dot(u_xlat7.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat7.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat28<0.00499999989);
#else
    u_xlatb27 = u_xlat28<0.00499999989;
#endif
    u_xlat28 = u_xlat28 * 8.29800034;
    u_xlat16_0.x = (u_xlatb27) ? 0.0 : u_xlat28;
    u_xlat16_8 = dot((-u_xlat3.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_8 = u_xlat16_8 + u_xlat16_8;
    u_xlat16_5.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_8)) + (-u_xlat3.xyz);
    u_xlat3.x = dot(u_xlat16_5.zxy, (-u_xlat16_5.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<9.99999975e-06);
#else
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
#endif
    u_xlat3.x = (u_xlatb3) ? u_xlat16_5.z : (-u_xlat16_5.z);
    u_xlat7.z = u_xlat3.x * u_xlat16_5.x;
    u_xlat3.x = u_xlat3.x * u_xlat16_5.z;
    u_xlat7.xy = (-u_xlat16_5.xy) * u_xlat16_5.yz;
    u_xlat3.yz = (-u_xlat16_5.xy) * u_xlat16_5.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat7.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat27 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat16_5.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_24);
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
mediump float u_xlat16_8;
float u_xlat12;
float u_xlat20;
mediump float u_xlat16_24;
float u_xlat27;
bool u_xlatb27;
float u_xlat28;
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
    u_xlat16_24 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_24 = u_xlat16_24 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_24) * _CameraNearColor.xyz;
    u_xlat3.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_3.xyz = texture(_CameraNearFogMap, u_xlat3.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_3.xyz;
    u_xlat16_24 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_24 = (-u_xlat16_24) + _Smoothness;
    u_xlat16_24 = u_xlat16_24 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = (-u_xlat16_5.xyz) + vec3(u_xlat16_24);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat3.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = u_xlat3.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat27 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 0.319999993);
    u_xlat28 = (-_Smoothness) + 1.0;
    u_xlat7.x = u_xlat28 * u_xlat28 + 1.5;
    u_xlat27 = u_xlat27 * u_xlat7.x;
    u_xlat7.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat7.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat12 = u_xlat28 * u_xlat28;
    u_xlat20 = u_xlat12 * u_xlat12 + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat20 + 1.00001001;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat27 = u_xlat12 / u_xlat27;
    u_xlat16_24 = u_xlat28 * u_xlat12;
    u_xlat16_24 = (-u_xlat16_24) * 0.280000001 + 1.0;
    u_xlat27 = u_xlat27 + -9.99999975e-05;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 100.0);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD6.xy);
    u_xlat16_2.x = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
    u_xlat4.xyz = u_xlat16_2.xyz * u_xlat4.xyz;
    u_xlat27 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat7.x = dot(u_xlat7.xyz, u_xlat3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat7.x) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_2.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat28<0.00499999989);
#else
    u_xlatb27 = u_xlat28<0.00499999989;
#endif
    u_xlat28 = u_xlat28 * 8.29800034;
    u_xlat16_0.x = (u_xlatb27) ? 0.0 : u_xlat28;
    u_xlat16_8 = dot((-u_xlat3.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_8 = u_xlat16_8 + u_xlat16_8;
    u_xlat16_5.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_8)) + (-u_xlat3.xyz);
    u_xlat3.x = dot(u_xlat16_5.zxy, (-u_xlat16_5.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<9.99999975e-06);
#else
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
#endif
    u_xlat3.x = (u_xlatb3) ? u_xlat16_5.z : (-u_xlat16_5.z);
    u_xlat7.z = u_xlat3.x * u_xlat16_5.x;
    u_xlat3.x = u_xlat3.x * u_xlat16_5.z;
    u_xlat7.xy = (-u_xlat16_5.xy) * u_xlat16_5.yz;
    u_xlat3.yz = (-u_xlat16_5.xy) * u_xlat16_5.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat7.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat27 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat27 = sin(u_xlat27);
    u_xlat27 = u_xlat27 * _NormalRand.w;
    u_xlat27 = fract(u_xlat27);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat27) + u_xlat16_5.xyz;
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_24);
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
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
  LOD 5000
  Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 112263
Program "vp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform highp sampler2D unity_NHxRoughness;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec3 u_xlat16_4;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
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
    u_xlat16_14 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_14 = max(u_xlat16_14, 0.0);
    u_xlat16_14 = u_xlat16_14 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_14) * _CameraNearColor.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_4.xyz = texture(_CameraNearFogMap, u_xlat4.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz;
    u_xlat16_4.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_14 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_4;
vec2 u_xlat6;
mediump float u_xlat16_6;
float u_xlat9;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
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
    u_xlat4.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
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
    u_xlat16_2.x = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xxx * _CameraNearColor.xyz;
    u_xlat6.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_1.xyz = texture(_CameraNearFogMap, u_xlat6.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat16_1.xyz * u_xlat16_2.xxx + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xzw;
    SV_Target0.xyz = u_xlat0.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat7;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = inversesqrt(u_xlat7);
    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_4;
vec2 u_xlat6;
mediump float u_xlat16_6;
float u_xlat9;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
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
    u_xlat4.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
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
    u_xlat16_2.x = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xxx * _CameraNearColor.xyz;
    u_xlat6.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_1.xyz = texture(_CameraNearFogMap, u_xlat6.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat16_1.xyz * u_xlat16_2.xxx + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xzw;
    SV_Target0.xyz = u_xlat0.xyz;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
uniform highp sampler2D unity_NHxRoughness;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec3 u_xlat16_4;
float u_xlat12;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD1.xyz;
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
    u_xlat16_14 = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_14 = max(u_xlat16_14, 0.0);
    u_xlat16_14 = u_xlat16_14 / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_14) * _CameraNearColor.xyz;
    u_xlat4.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_4.xyz = texture(_CameraNearFogMap, u_xlat4.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_3.xyz;
    u_xlat16_4.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_3.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_14 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_14) + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.x = vs_TEXCOORD6;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_4;
vec2 u_xlat6;
mediump float u_xlat16_6;
float u_xlat9;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
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
    u_xlat4.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
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
    u_xlat16_2.x = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xxx * _CameraNearColor.xyz;
    u_xlat6.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_1.xyz = texture(_CameraNearFogMap, u_xlat6.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat16_1.xyz * u_xlat16_2.xxx + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xzw;
    u_xlat9 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _CameraNearFogMap_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD6;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD6 = max(u_xlat1.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _CameraNearFogMap_ST.xy + _CameraNearFogMap_ST.zw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump float _CameraNearColorMaxDistance;
uniform 	mediump vec4 _CameraNearColor;
uniform 	mediump vec2 _CameraNearColorUVScale;
uniform mediump sampler2D _CameraNearFogMap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD6;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_4;
vec2 u_xlat6;
mediump float u_xlat16_6;
float u_xlat9;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
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
    u_xlat4.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * vs_TEXCOORD1.xyz;
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
    u_xlat16_2.x = (-vs_TEXCOORD3.w) + _CameraNearColorMaxDistance;
    u_xlat16_2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = u_xlat16_2.x / _CameraNearColorMaxDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xxx * _CameraNearColor.xyz;
    u_xlat6.xy = vs_TEXCOORD0.xy * _CameraNearColorUVScale.xy;
    u_xlat16_1.xyz = texture(_CameraNearFogMap, u_xlat6.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = _Color.xyz * vs_COLOR0.xyz + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_1.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_2.xyz;
    u_xlat16_2.x = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat16_1.xyz * u_xlat16_2.xxx + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xzw;
    u_xlat9 = vs_TEXCOORD6;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat9);
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
SubShader {
 LOD 2500
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 2500
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
  GpuProgramID 249942
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_7;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_7;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_7;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_13 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_13 = max(u_xlat16_13, 0.0);
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_13 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_13 = max(u_xlat16_13, 0.0);
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_13 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_13 = max(u_xlat16_13, 0.0);
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_ShadowMask;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_16 = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat16_16) * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_16 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = max(u_xlat16_16, 0.0);
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_ShadowMask;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_16 = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat16_16) * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_16 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = max(u_xlat16_16, 0.0);
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_ShadowMask;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_16 = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat16_16) * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_16 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = max(u_xlat16_16, 0.0);
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_10 = max(u_xlat16_10, 0.0);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_10 = max(u_xlat16_10, 0.0);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_10 = max(u_xlat16_10, 0.0);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
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
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
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
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
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
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_13;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_13 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_13 = max(u_xlat16_13, 0.0);
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_13;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_13 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_13 = max(u_xlat16_13, 0.0);
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_13;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_13 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_13 = max(u_xlat16_13, 0.0);
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_18;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
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
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_18 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_18) * _LightColor0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_18 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_18 = max(u_xlat16_18, 0.0);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_18) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_18;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
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
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_18 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_18) * _LightColor0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_18 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_18 = max(u_xlat16_18, 0.0);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_18) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_18;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
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
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_18 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_18) * _LightColor0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_18 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_18 = max(u_xlat16_18, 0.0);
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_18) + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat16_0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_7) + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat16_0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_7) + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
float u_xlat6;
mediump float u_xlat16_7;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat16_0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_7) + (-unity_FogColor.xyz);
    u_xlat6 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_13 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_13 = max(u_xlat16_13, 0.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat12 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_13 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_13 = max(u_xlat16_13, 0.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat12 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_13 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_13 = max(u_xlat16_13, 0.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat12 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_ShadowMask;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_16 = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat16_16) * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_16 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = max(u_xlat16_16, 0.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_ShadowMask;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_16 = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat16_16) * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_16 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = max(u_xlat16_16, 0.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD2.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_ShadowMask;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat15;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_16 = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat16_16) * _LightColor0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz;
    u_xlat16_16 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_16 = max(u_xlat16_16, 0.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat15 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_10 = max(u_xlat16_10, 0.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_10 = max(u_xlat16_10, 0.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_10 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_10 = max(u_xlat16_10, 0.0);
    u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat18;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
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
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat18 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat18;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
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
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat18 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_15;
float u_xlat18;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
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
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * _LightColor0.xyz;
    u_xlat16_15 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_15 = max(u_xlat16_15, 0.0);
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_15) + u_xlat16_0.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat18 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_13 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_13 = max(u_xlat16_13, 0.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat12 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_13 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_13 = max(u_xlat16_13, 0.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat12 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_13 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_13 = max(u_xlat16_13, 0.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_13) + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat12 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_18;
float u_xlat21;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
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
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_18 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_18) * _LightColor0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_18 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_18 = max(u_xlat16_18, 0.0);
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_18) + u_xlat16_0.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat21 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_18;
float u_xlat21;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
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
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_18 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_18) * _LightColor0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_18 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_18 = max(u_xlat16_18, 0.0);
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_18) + u_xlat16_0.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat21 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD3 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD4.xy = u_xlat0.xy;
    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_18;
float u_xlat21;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_0.x = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_0.x);
    u_xlat16_1 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_0.xyz = unity_SHC.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.xyz;
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
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD4.xy);
    u_xlat16_18 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_18) * _LightColor0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_18 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_18 = max(u_xlat16_18, 0.0);
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_18) + u_xlat16_0.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat21 = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat21) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
}
}
 Pass {
  Name "FORWARD"
  LOD 2500
  Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 309932
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_7;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_7;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_7;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_7;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat16_1.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_7;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat16_1.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_7;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
    u_xlat16_7 = dot(vs_TEXCOORD0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_7 = max(u_xlat16_7, 0.0);
    u_xlat16_1.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx;
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
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
}
}
 Pass {
  Name "PREPASS"
  LOD 2500
  Tags { "LIGHTMODE" = "PREPASSBASE" "RenderType" = "Opaque" }
  GpuProgramID 357836
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_Target0.w = 0.0;
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
 Pass {
  Name "PREPASS"
  LOD 2500
  Tags { "LIGHTMODE" = "PREPASSFINAL" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 420775
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = (-u_xlat16_1.xyz) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = (-u_xlat16_1.xyz) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = (-u_xlat16_1.xyz) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = (-u_xlat16_1.xyz) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = (-u_xlat16_1.xyz) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = (-u_xlat16_1.xyz) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = (-u_xlat16_1.xyz) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = (-u_xlat16_1.xyz) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = (-u_xlat16_1.xyz) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2.x = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat1.x, u_xlat16_2.x);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = (-u_xlat16_1.xyz) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2.x = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat1.x, u_xlat16_2.x);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = (-u_xlat16_1.xyz) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2.x = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat1.x, u_xlat16_2.x);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = (-u_xlat16_1.xyz) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2.x = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat1.x, u_xlat16_2.x);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = (-u_xlat16_1.xyz) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2.x = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat1.x, u_xlat16_2.x);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = (-u_xlat16_1.xyz) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2.x = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat1.x, u_xlat16_2.x);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = (-u_xlat16_1.xyz) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2.x = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat1.x, u_xlat16_2.x);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = (-u_xlat16_1.xyz) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2.x = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat1.x, u_xlat16_2.x);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = (-u_xlat16_1.xyz) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat1.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2.x = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat1.x, u_xlat16_2.x);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat0.zw;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat0.xyz = log2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat0.xyz = (-u_xlat16_1.xyz) + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD4 = max(u_xlat16_3, u_xlat0.x);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat4 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD4 = max(u_xlat16_3, u_xlat0.x);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat4 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD4 = max(u_xlat16_3, u_xlat0.x);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat4 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD4 = max(u_xlat16_3, u_xlat0.x);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat4 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD4 = max(u_xlat16_3, u_xlat0.x);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat4 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD4 = max(u_xlat16_3, u_xlat0.x);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat4 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD4 = max(u_xlat16_3, u_xlat0.x);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat4 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD4 = max(u_xlat16_3, u_xlat0.x);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat4 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD4 = max(u_xlat16_3, u_xlat0.x);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat4 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD4 = max(u_xlat16_3, u_xlat0.x);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat4 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD4 = max(u_xlat16_3, u_xlat0.x);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat4 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp float vs_TEXCOORD4;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
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
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    u_xlat16_3 = (-unity_FogColor.w) + 1.0;
    u_xlat0.x = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD4 = max(u_xlat16_3, u_xlat0.x);
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat2.zw;
    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat4 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat4 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D _LightBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp float vs_TEXCOORD4;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat16_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
    u_xlat16_1.xyz = max(u_xlat16_0.xyz, vec3(0.00100000005, 0.00100000005, 0.00100000005));
    u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat9 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
#else
    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
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
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" }
""
}
}
}
 Pass {
  Name "DEFERRED"
  LOD 2500
  Tags { "LIGHTMODE" = "DEFERRED" "RenderType" = "Opaque" }
  GpuProgramID 513572
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_2.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_2.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_2.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_19;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_19 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_19 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_19);
    u_xlat16_0 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_2.xyz = unity_SHC.xyz * vec3(u_xlat16_19) + u_xlat16_2.xyz;
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_19;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_19 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_19 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_19);
    u_xlat16_0 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_2.xyz = unity_SHC.xyz * vec3(u_xlat16_19) + u_xlat16_2.xyz;
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_19;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_19 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_19 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_19);
    u_xlat16_0 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_2.xyz = unity_SHC.xyz * vec3(u_xlat16_19) + u_xlat16_2.xyz;
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_19;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_19 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_19 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_19);
    u_xlat16_0 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_2.xyz = unity_SHC.xyz * vec3(u_xlat16_19) + u_xlat16_2.xyz;
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_19;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_19 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_19 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_19);
    u_xlat16_0 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_2.xyz = unity_SHC.xyz * vec3(u_xlat16_19) + u_xlat16_2.xyz;
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
float u_xlat9;
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
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz * unity_ShadowFadeCenterAndType.www;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
    u_xlat0.x = u_xlat1.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat1.x + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat1.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat1.w + u_xlat0.x;
    u_xlat3 = (-unity_ShadowFadeCenterAndType.w) + 1.0;
    vs_TEXCOORD3.w = u_xlat3 * (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 booster_PowerSavingAdjustColor;
uniform mediump sampler2D unity_Lightmap;
in highp vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
layout(location = 1) out mediump vec4 SV_Target1;
layout(location = 2) out mediump vec4 SV_Target2;
layout(location = 3) out mediump vec4 SV_Target3;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_19;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_1.xyz = (-booster_PowerSavingAdjustColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat0.w = 1.0;
    SV_Target2 = u_xlat0;
    u_xlat16_19 = vs_TEXCOORD0.y * vs_TEXCOORD0.y;
    u_xlat16_19 = vs_TEXCOORD0.x * vs_TEXCOORD0.x + (-u_xlat16_19);
    u_xlat16_0 = vs_TEXCOORD0.yzzx * vs_TEXCOORD0.xyzz;
    u_xlat16_2.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_2.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_2.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_2.xyz = unity_SHC.xyz * vec3(u_xlat16_19) + u_xlat16_2.xyz;
    u_xlat0.xyz = vs_TEXCOORD0.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_2.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_5.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = unity_Lightmap_HDR.xxx * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    SV_Target3.xyz = exp2((-u_xlat16_1.xyz));
    SV_Target3.w = 1.0;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
""
}
}
}
}
Fallback "Booster/Black"
}