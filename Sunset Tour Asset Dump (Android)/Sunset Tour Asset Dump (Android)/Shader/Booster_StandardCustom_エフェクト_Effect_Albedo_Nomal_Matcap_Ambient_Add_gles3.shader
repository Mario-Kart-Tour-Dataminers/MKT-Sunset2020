//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/StandardCustom/エフェクト/Effect_Albedo_Nomal_Matcap_Ambient_Add" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_FixedAmbientColor ("固定環境光色", Color) = (1,1,1,1)
_MainTex ("Albedo(UV0)", 2D) = "white" { }
_Metallic ("Metallic", Range(0, 1)) = 0
_Smoothness ("Smoothness", Range(0, 1)) = 0
_Occlusion ("Occlusion", Range(0, 1)) = 1
_SphereMap ("SphereMap", 2D) = "black" { }
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
  GpuProgramID 17252
Program "vp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
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
float u_xlat6;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
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
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_2.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_1 = vs_COLOR0 + _Color;
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_18 = u_xlat16_1.w * u_xlat16_3.w;
    SV_Target0.w = u_xlat16_18;
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
uniform 	vec4 _MainTex_ST;
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
float u_xlat6;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
float u_xlat18;
float u_xlat27;
float u_xlat30;
mediump float u_xlat16_32;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat10.xyz = u_xlat9.xyz * vec3(u_xlat1);
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat10.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat10.xyz);
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
    u_xlat30 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat30;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_32 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32);
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_32 = (-u_xlat10.x) + 1.0;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_33 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_34 = (-u_xlat16_33) + _Smoothness;
    u_xlat16_34 = u_xlat16_34 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_34);
    u_xlat16_8.xyz = vec3(u_xlat16_32) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat10.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat10.x = max(u_xlat10.x, 0.00100000005);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat9.xyz = u_xlat9.xyz * u_xlat10.xxx;
    u_xlat10.x = dot(_WorldSpaceLightPos0.xyz, u_xlat9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat9.x = dot(u_xlat3.xyz, u_xlat9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat18 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat9.x * u_xlat9.x;
    u_xlat27 = max(u_xlat10.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat27;
    u_xlat27 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat9.x = u_xlat9.x * u_xlat27 + 1.00001001;
    u_xlat0.x = u_xlat9.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyw = u_xlat16_6.xyz * vec3(u_xlat16_33) + u_xlat0.xyw;
    u_xlat0.xyw = u_xlat0.xyw * _LightColor0.xyz;
    u_xlat2.xyz = u_xlat0.xyw * vec3(u_xlat18) + u_xlat16_5.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
float u_xlat6;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
float u_xlat18;
float u_xlat27;
float u_xlat30;
mediump float u_xlat16_32;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat10.xyz = u_xlat9.xyz * vec3(u_xlat1);
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat10.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat10.xyz);
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
    u_xlat30 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat30;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_32 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32);
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_32 = (-u_xlat10.x) + 1.0;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_33 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_34 = (-u_xlat16_33) + _Smoothness;
    u_xlat16_34 = u_xlat16_34 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_34);
    u_xlat16_8.xyz = vec3(u_xlat16_32) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat10.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat10.x = max(u_xlat10.x, 0.00100000005);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat9.xyz = u_xlat9.xyz * u_xlat10.xxx;
    u_xlat10.x = dot(_WorldSpaceLightPos0.xyz, u_xlat9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat9.x = dot(u_xlat3.xyz, u_xlat9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat18 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat9.x * u_xlat9.x;
    u_xlat27 = max(u_xlat10.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat27;
    u_xlat27 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat9.x = u_xlat9.x * u_xlat27 + 1.00001001;
    u_xlat0.x = u_xlat9.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyw = u_xlat16_6.xyz * vec3(u_xlat16_33) + u_xlat0.xyw;
    u_xlat0.xyw = u_xlat0.xyw * _LightColor0.xyz;
    u_xlat2.xyz = u_xlat0.xyw * vec3(u_xlat18) + u_xlat16_5.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump float u_xlat16_21;
mediump float u_xlat16_30;
float u_xlat31;
bool u_xlatb31;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat16_0.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat1.xyz = vec3(u_xlat31) * u_xlat1.xyz;
    u_xlat16_30 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_30 = u_xlat16_30 + u_xlat16_30;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_30)) + (-u_xlat1.xyz);
    u_xlat31 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat31<9.99999975e-06);
#else
    u_xlatb31 = u_xlat31<9.99999975e-06;
#endif
    u_xlat31 = (u_xlatb31) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat31 * u_xlat16_2.x;
    u_xlat4.x = u_xlat31 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat3.xyz = vec3(u_xlat31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat31 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat31 = sin(u_xlat31);
    u_xlat31 = u_xlat31 * _NormalRand.w;
    u_xlat31 = fract(u_xlat31);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat31) + u_xlat16_2.xyz;
    u_xlat31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat3.xyz = vec3(u_xlat31) * u_xlat3.xyz;
    u_xlat4.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb31 = u_xlat4.z<0.00499999989;
#endif
    u_xlat33 = u_xlat4.z * 8.29800034;
    u_xlat16_30 = (u_xlatb31) ? 0.0 : u_xlat33;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_30);
    u_xlat16_30 = u_xlat16_2.w + -1.0;
    u_xlat16_30 = unity_SpecCube0_HDR.w * u_xlat16_30 + 1.0;
    u_xlat16_30 = u_xlat16_30 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_30);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat31 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat3.xyz = vec3(u_xlat31) * vs_TEXCOORD1.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat33 = u_xlat31;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat31 = u_xlat31 + u_xlat31;
    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat31)) + u_xlat1.xyz;
    u_xlat31 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat31) * _LightColor0.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_30 = (-u_xlat33) + 1.0;
    u_xlat16_11 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_11 = u_xlat16_30 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_30 * u_xlat16_11;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat3.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat3.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_3.xyz = texture(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_21 = u_xlat16_2.w * u_xlat16_4.w;
    SV_Target0.w = u_xlat16_21;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_30 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_35 = (-u_xlat16_30) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_30) * u_xlat16_7.xyz;
    u_xlat16_30 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_30);
    u_xlat16_9.xyz = vec3(u_xlat16_11) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat1.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_8.xyz * u_xlat16_6.xyz + u_xlat16_0.xyz;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
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
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_6.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
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
    u_xlat16_7.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_6.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
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
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_6.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
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
    u_xlat16_7.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_6.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
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
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_10;
mediump float u_xlat16_19;
mediump float u_xlat16_27;
float u_xlat28;
bool u_xlatb28;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat16_0.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat16_27 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_27)) + (-u_xlat1.xyz);
    u_xlat28 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(u_xlat28<9.99999975e-06);
#else
    u_xlatb28 = u_xlat28<9.99999975e-06;
#endif
    u_xlat28 = (u_xlatb28) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat28 * u_xlat16_2.x;
    u_xlat4.x = u_xlat28 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat28 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat28 = sin(u_xlat28);
    u_xlat28 = u_xlat28 * _NormalRand.w;
    u_xlat28 = fract(u_xlat28);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat4.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb28 = u_xlat4.z<0.00499999989;
#endif
    u_xlat30 = u_xlat4.z * 8.29800034;
    u_xlat16_27 = (u_xlatb28) ? 0.0 : u_xlat30;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_27);
    u_xlat16_27 = u_xlat16_2.w + -1.0;
    u_xlat16_27 = unity_SpecCube0_HDR.w * u_xlat16_27 + 1.0;
    u_xlat16_27 = u_xlat16_27 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_27);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat28 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD1.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat30 = u_xlat28;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat1.xyz;
    u_xlat28 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_27 = (-u_xlat30) + 1.0;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_10;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat3.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat3.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_3.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_19 = u_xlat16_2.w * u_xlat16_4.w;
    SV_Target0.w = u_xlat16_19;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_27 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_27) + _Smoothness;
    u_xlat16_6.xyz = vec3(u_xlat16_27) * u_xlat16_6.xyz;
    u_xlat16_27 = u_xlat16_32 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_27);
    u_xlat16_8.xyz = vec3(u_xlat16_10) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat1.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_27 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_27) * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat28) * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_0.xyz;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
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
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
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
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_6.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_9.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
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
    u_xlat16_7.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_6.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
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
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
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
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_6.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_9.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
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
    u_xlat16_7.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_6.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
float u_xlat6;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
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
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
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
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_2.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_1 = vs_COLOR0 + _Color;
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_18 = u_xlat16_1.w * u_xlat16_3.w;
    SV_Target0.w = u_xlat16_18;
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
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_8.xyz * u_xlat16_6.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
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
uniform 	vec4 _MainTex_ST;
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
float u_xlat6;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
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
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_6.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
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
    u_xlat16_7.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_6.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
float u_xlat6;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
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
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_6.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
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
    u_xlat16_7.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_6.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
float u_xlat6;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
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
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump float u_xlat16_21;
mediump float u_xlat16_30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
mediump float u_xlat16_33;
void main()
{
    u_xlat16_0.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat1.xyz = vec3(u_xlat31) * u_xlat1.xyz;
    u_xlat16_30 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_30 = u_xlat16_30 + u_xlat16_30;
    u_xlat16_3.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_30)) + (-u_xlat1.xyz);
    u_xlat31 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat31<9.99999975e-06);
#else
    u_xlatb31 = u_xlat31<9.99999975e-06;
#endif
    u_xlat31 = (u_xlatb31) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat2.z = u_xlat31 * u_xlat16_3.x;
    u_xlat4.x = u_xlat31 * u_xlat16_3.z;
    u_xlat2.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat4.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat31 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat31 = sin(u_xlat31);
    u_xlat31 = u_xlat31 * _NormalRand.w;
    u_xlat31 = fract(u_xlat31);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat31) + u_xlat16_3.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat4.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb31 = u_xlat4.z<0.00499999989;
#endif
    u_xlat32 = u_xlat4.z * 8.29800034;
    u_xlat16_30 = (u_xlatb31) ? 0.0 : u_xlat32;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_30);
    u_xlat16_30 = u_xlat16_2.w + -1.0;
    u_xlat16_30 = unity_SpecCube0_HDR.w * u_xlat16_30 + 1.0;
    u_xlat16_30 = u_xlat16_30 * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(u_xlat16_30);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Occlusion);
    u_xlat31 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat2.xyz = vec3(u_xlat31) * vs_TEXCOORD1.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat32 = u_xlat31;
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat31 = u_xlat31 + u_xlat31;
    u_xlat1.xyz = u_xlat2.xyz * (-vec3(u_xlat31)) + u_xlat1.xyz;
    u_xlat31 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat31) * _LightColor0.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_30 = (-u_xlat32) + 1.0;
    u_xlat16_11 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_11 = u_xlat16_30 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_30 * u_xlat16_11;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_2.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_4 = vs_COLOR0 + _Color;
    u_xlat16_6 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat16_21 = u_xlat16_4.w * u_xlat16_6.w;
    SV_Target0.w = u_xlat16_21;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_30 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_33 = (-u_xlat16_30) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_30) * u_xlat16_7.xyz;
    u_xlat16_30 = u_xlat16_33 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_30);
    u_xlat16_9.xyz = vec3(u_xlat16_11) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat1.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_9.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_8.xyz * u_xlat16_5.xyz + u_xlat16_0.xyz;
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
uniform 	vec4 _MainTex_ST;
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
float u_xlat6;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
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
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
float u_xlat22;
float u_xlat33;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat12.xyz = u_xlat11.xyz * vec3(u_xlat1);
    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1;
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
    u_xlat22 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22 + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_11.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_11.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_38) * u_xlat16_6.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_38);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_10.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat33 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat1) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat16_6.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
float u_xlat6;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
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
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
float u_xlat22;
float u_xlat33;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat12.xyz = u_xlat11.xyz * vec3(u_xlat1);
    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1;
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
    u_xlat22 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22 + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_11.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_11.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_38) * u_xlat16_6.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_38);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_10.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat33 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat1) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat16_6.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
float u_xlat6;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
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
mediump vec4 u_xlat16_3;
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
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_5.x = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_5.y = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_5.xy = u_xlat16_5.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_2.xyz = texture(_SphereMap, u_xlat16_5.xy).xyz;
    u_xlat16_1 = vs_COLOR0 + _Color;
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_16 = u_xlat16_1.w * u_xlat16_3.w;
    SV_Target0.w = u_xlat16_16;
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
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_28 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_28) * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat24) * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
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
uniform 	vec4 _MainTex_ST;
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
float u_xlat6;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
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
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
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
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_6.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
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
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
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
    u_xlat16_7.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_6.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
float u_xlat6;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
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
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
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
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_6.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
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
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
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
    u_xlat16_7.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_6.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
float u_xlat6;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
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
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_10;
mediump float u_xlat16_19;
mediump float u_xlat16_27;
float u_xlat28;
bool u_xlatb28;
float u_xlat29;
mediump float u_xlat16_30;
void main()
{
    u_xlat16_0.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat16_27 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_3.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_27)) + (-u_xlat1.xyz);
    u_xlat28 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(u_xlat28<9.99999975e-06);
#else
    u_xlatb28 = u_xlat28<9.99999975e-06;
#endif
    u_xlat28 = (u_xlatb28) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat2.z = u_xlat28 * u_xlat16_3.x;
    u_xlat4.x = u_xlat28 * u_xlat16_3.z;
    u_xlat2.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat4.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat28 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat28 = sin(u_xlat28);
    u_xlat28 = u_xlat28 * _NormalRand.w;
    u_xlat28 = fract(u_xlat28);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28) + u_xlat16_3.xyz;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * u_xlat2.xyz;
    u_xlat4.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb28 = u_xlat4.z<0.00499999989;
#endif
    u_xlat29 = u_xlat4.z * 8.29800034;
    u_xlat16_27 = (u_xlatb28) ? 0.0 : u_xlat29;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_27);
    u_xlat16_27 = u_xlat16_2.w + -1.0;
    u_xlat16_27 = unity_SpecCube0_HDR.w * u_xlat16_27 + 1.0;
    u_xlat16_27 = u_xlat16_27 * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(u_xlat16_27);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Occlusion);
    u_xlat28 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * vs_TEXCOORD1.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat29 = u_xlat28;
#ifdef UNITY_ADRENO_ES3
    u_xlat29 = min(max(u_xlat29, 0.0), 1.0);
#else
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
#endif
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat1.xyz = u_xlat2.xyz * (-vec3(u_xlat28)) + u_xlat1.xyz;
    u_xlat28 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_27 = (-u_xlat29) + 1.0;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_10;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_5.x = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_5.y = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_5.xy = u_xlat16_5.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_2.xyz = texture(_SphereMap, u_xlat16_5.xy).xyz;
    u_xlat16_4 = vs_COLOR0 + _Color;
    u_xlat16_5 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_19 = u_xlat16_4.w * u_xlat16_5.w;
    SV_Target0.w = u_xlat16_19;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_27 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_30 = (-u_xlat16_27) + _Smoothness;
    u_xlat16_6.xyz = vec3(u_xlat16_27) * u_xlat16_6.xyz;
    u_xlat16_27 = u_xlat16_30 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_27);
    u_xlat16_8.xyz = vec3(u_xlat16_10) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat1.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_27 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = vec3(u_xlat16_27) * _LightColor0.xyz;
    u_xlat16_3.xyz = vec3(u_xlat28) * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_3.xyz + u_xlat16_0.xyz;
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
uniform 	vec4 _MainTex_ST;
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
float u_xlat6;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
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
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
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
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
float u_xlat22;
float u_xlat33;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat12.xyz = u_xlat11.xyz * vec3(u_xlat1);
    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1;
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
    u_xlat22 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22 + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_11.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_11.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_38) * u_xlat16_6.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_38);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_38 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_38) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_9.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_10.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat33 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat1) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat16_6.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
float u_xlat6;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
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
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
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
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
float u_xlat22;
float u_xlat33;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat12.xyz = u_xlat11.xyz * vec3(u_xlat1);
    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1;
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
    u_xlat22 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22 + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_11.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_11.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_38) * u_xlat16_6.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_38);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_38 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_38) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_9.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_10.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat33 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat1) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat16_6.xyz;
    u_xlat2.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
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
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_2.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_1 = vs_COLOR0 + _Color;
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.w = u_xlat16_1.w * u_xlat16_3.w;
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
    u_xlat16_0.xyz = u_xlat16_4.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
float u_xlat18;
float u_xlat27;
float u_xlat30;
mediump float u_xlat16_32;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat10.xyz = u_xlat9.xyz * vec3(u_xlat1);
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat10.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat10.xyz);
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
    u_xlat30 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat30;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_32 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32);
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_32 = (-u_xlat10.x) + 1.0;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_33 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_34 = (-u_xlat16_33) + _Smoothness;
    u_xlat16_34 = u_xlat16_34 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_34);
    u_xlat16_8.xyz = vec3(u_xlat16_32) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat10.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat10.x = max(u_xlat10.x, 0.00100000005);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat9.xyz = u_xlat9.xyz * u_xlat10.xxx;
    u_xlat10.x = dot(_WorldSpaceLightPos0.xyz, u_xlat9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat9.x = dot(u_xlat3.xyz, u_xlat9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat18 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat9.x * u_xlat9.x;
    u_xlat27 = max(u_xlat10.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat27;
    u_xlat27 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat9.x = u_xlat9.x * u_xlat27 + 1.00001001;
    u_xlat0.x = u_xlat9.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyw = u_xlat16_6.xyz * vec3(u_xlat16_33) + u_xlat0.xyw;
    u_xlat0.xyw = u_xlat0.xyw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * vec3(u_xlat18) + u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat9;
vec3 u_xlat10;
mediump vec3 u_xlat16_10;
float u_xlat18;
float u_xlat27;
float u_xlat30;
mediump float u_xlat16_32;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat10.xyz = u_xlat9.xyz * vec3(u_xlat1);
    u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat10.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat10.xyz);
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
    u_xlat30 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat30;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_32 = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_32 = (-u_xlat16_32) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_32);
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat10.x = dot(u_xlat3.xyz, u_xlat10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat16_32 = (-u_xlat10.x) + 1.0;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_32 = u_xlat16_32 * u_xlat16_32;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_33 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_34 = (-u_xlat16_33) + _Smoothness;
    u_xlat16_34 = u_xlat16_34 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_34 = min(max(u_xlat16_34, 0.0), 1.0);
#else
    u_xlat16_34 = clamp(u_xlat16_34, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_34);
    u_xlat16_8.xyz = vec3(u_xlat16_32) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat10.x = dot(u_xlat9.xyz, u_xlat9.xyz);
    u_xlat10.x = max(u_xlat10.x, 0.00100000005);
    u_xlat10.x = inversesqrt(u_xlat10.x);
    u_xlat9.xyz = u_xlat9.xyz * u_xlat10.xxx;
    u_xlat10.x = dot(_WorldSpaceLightPos0.xyz, u_xlat9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
    u_xlat9.x = dot(u_xlat3.xyz, u_xlat9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat18 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat9.x * u_xlat9.x;
    u_xlat27 = max(u_xlat10.x, 0.319999993);
    u_xlat0.x = u_xlat0.x * u_xlat27;
    u_xlat27 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat9.x = u_xlat9.x * u_xlat27 + 1.00001001;
    u_xlat0.x = u_xlat9.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyw = u_xlat16_6.xyz * vec3(u_xlat16_33) + u_xlat0.xyw;
    u_xlat0.xyw = u_xlat0.xyw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyw * vec3(u_xlat18) + u_xlat16_5.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
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
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump float u_xlat16_30;
float u_xlat31;
bool u_xlatb31;
float u_xlat33;
mediump float u_xlat16_35;
void main()
{
    u_xlat16_0.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat1.xyz = vec3(u_xlat31) * u_xlat1.xyz;
    u_xlat16_30 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_30 = u_xlat16_30 + u_xlat16_30;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_30)) + (-u_xlat1.xyz);
    u_xlat31 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat31<9.99999975e-06);
#else
    u_xlatb31 = u_xlat31<9.99999975e-06;
#endif
    u_xlat31 = (u_xlatb31) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat31 * u_xlat16_2.x;
    u_xlat4.x = u_xlat31 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat3.xyz = vec3(u_xlat31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat31 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat31 = sin(u_xlat31);
    u_xlat31 = u_xlat31 * _NormalRand.w;
    u_xlat31 = fract(u_xlat31);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat31) + u_xlat16_2.xyz;
    u_xlat31 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat3.xyz = vec3(u_xlat31) * u_xlat3.xyz;
    u_xlat4.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb31 = u_xlat4.z<0.00499999989;
#endif
    u_xlat33 = u_xlat4.z * 8.29800034;
    u_xlat16_30 = (u_xlatb31) ? 0.0 : u_xlat33;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_30);
    u_xlat16_30 = u_xlat16_2.w + -1.0;
    u_xlat16_30 = unity_SpecCube0_HDR.w * u_xlat16_30 + 1.0;
    u_xlat16_30 = u_xlat16_30 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_30);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat31 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat3.xyz = vec3(u_xlat31) * vs_TEXCOORD1.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat33 = u_xlat31;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat31 = u_xlat31 + u_xlat31;
    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat31)) + u_xlat1.xyz;
    u_xlat31 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat31) * _LightColor0.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_30 = (-u_xlat33) + 1.0;
    u_xlat16_11 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_11 = u_xlat16_30 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_30 * u_xlat16_11;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_7.x = dot(u_xlat3.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_7.y = dot(u_xlat3.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_7.xy = u_xlat16_7.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_3.xyz = texture(_SphereMap, u_xlat16_7.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_30 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_35 = (-u_xlat16_30) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_30) * u_xlat16_7.xyz;
    u_xlat16_30 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_30);
    u_xlat16_9.xyz = vec3(u_xlat16_11) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat1.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz + u_xlat16_5.xyz;
    u_xlat16_0.xyz = u_xlat16_8.xyz * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat31 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat31) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
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
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
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
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_6.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
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
    u_xlat16_7.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
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
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
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
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_6.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
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
    u_xlat16_7.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
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
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
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
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_10;
mediump float u_xlat16_27;
float u_xlat28;
bool u_xlatb28;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat16_0.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = u_xlat16_1.xyz * vec3(_Occlusion);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat16_27 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_27)) + (-u_xlat1.xyz);
    u_xlat28 = dot(u_xlat16_2.zxy, (-u_xlat16_2.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(u_xlat28<9.99999975e-06);
#else
    u_xlatb28 = u_xlat28<9.99999975e-06;
#endif
    u_xlat28 = (u_xlatb28) ? u_xlat16_2.z : (-u_xlat16_2.z);
    u_xlat3.z = u_xlat28 * u_xlat16_2.x;
    u_xlat4.x = u_xlat28 * u_xlat16_2.z;
    u_xlat3.xy = (-u_xlat16_2.xy) * u_xlat16_2.yz;
    u_xlat4.yz = (-u_xlat16_2.xy) * u_xlat16_2.xy;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat28 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat28 = sin(u_xlat28);
    u_xlat28 = u_xlat28 * _NormalRand.w;
    u_xlat28 = fract(u_xlat28);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat28) + u_xlat16_2.xyz;
    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
    u_xlat4.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb28 = u_xlat4.z<0.00499999989;
#endif
    u_xlat30 = u_xlat4.z * 8.29800034;
    u_xlat16_27 = (u_xlatb28) ? 0.0 : u_xlat30;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_27);
    u_xlat16_27 = u_xlat16_2.w + -1.0;
    u_xlat16_27 = unity_SpecCube0_HDR.w * u_xlat16_27 + 1.0;
    u_xlat16_27 = u_xlat16_27 * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_27);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat28 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat3.xyz = vec3(u_xlat28) * vs_TEXCOORD1.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat3.xyz);
    u_xlat30 = u_xlat28;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat1.xyz = u_xlat3.xyz * (-vec3(u_xlat28)) + u_xlat1.xyz;
    u_xlat28 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_27 = (-u_xlat30) + 1.0;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_10;
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat3.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat3.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat3.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat3.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_3.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_27 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_32 = (-u_xlat16_27) + _Smoothness;
    u_xlat16_6.xyz = vec3(u_xlat16_27) * u_xlat16_6.xyz;
    u_xlat16_27 = u_xlat16_32 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_27);
    u_xlat16_8.xyz = vec3(u_xlat16_10) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat1.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_3 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_27 = dot(u_xlat16_3, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_27) * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat28) * u_xlat16_5.xyz;
    u_xlat16_0.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat28 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat28) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
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
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
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
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
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
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_6.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_9.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
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
    u_xlat16_7.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat12;
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
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    u_xlat16_2 = u_xlat0.y * u_xlat0.y;
    u_xlat16_2 = u_xlat0.x * u_xlat0.x + (-u_xlat16_2);
    u_xlat16_0 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_0);
    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat16_2) + u_xlat16_3.xyz;
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
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
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
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_6.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_9.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = u_xlat16_4.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
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
    u_xlat16_7.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
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
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
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
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_2.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_1 = vs_COLOR0 + _Color;
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.w = u_xlat16_1.w * u_xlat16_3.w;
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
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_8.xyz * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
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
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_6.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
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
    u_xlat16_7.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
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
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_6.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
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
    u_xlat16_7.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
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
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump float u_xlat16_30;
float u_xlat31;
bool u_xlatb31;
float u_xlat32;
mediump float u_xlat16_33;
void main()
{
    u_xlat16_0.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat1.xyz = vec3(u_xlat31) * u_xlat1.xyz;
    u_xlat16_30 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_30 = u_xlat16_30 + u_xlat16_30;
    u_xlat16_3.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_30)) + (-u_xlat1.xyz);
    u_xlat31 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat31<9.99999975e-06);
#else
    u_xlatb31 = u_xlat31<9.99999975e-06;
#endif
    u_xlat31 = (u_xlatb31) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat2.z = u_xlat31 * u_xlat16_3.x;
    u_xlat4.x = u_xlat31 * u_xlat16_3.z;
    u_xlat2.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat4.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat31 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat31 = sin(u_xlat31);
    u_xlat31 = u_xlat31 * _NormalRand.w;
    u_xlat31 = fract(u_xlat31);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat31) + u_xlat16_3.xyz;
    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat2.xyz = vec3(u_xlat31) * u_xlat2.xyz;
    u_xlat4.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb31 = u_xlat4.z<0.00499999989;
#endif
    u_xlat32 = u_xlat4.z * 8.29800034;
    u_xlat16_30 = (u_xlatb31) ? 0.0 : u_xlat32;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_30);
    u_xlat16_30 = u_xlat16_2.w + -1.0;
    u_xlat16_30 = unity_SpecCube0_HDR.w * u_xlat16_30 + 1.0;
    u_xlat16_30 = u_xlat16_30 * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(u_xlat16_30);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Occlusion);
    u_xlat31 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat31 = inversesqrt(u_xlat31);
    u_xlat2.xyz = vec3(u_xlat31) * vs_TEXCOORD1.xyz;
    u_xlat31 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat32 = u_xlat31;
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat31 = u_xlat31 + u_xlat31;
    u_xlat1.xyz = u_xlat2.xyz * (-vec3(u_xlat31)) + u_xlat1.xyz;
    u_xlat31 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat31) * _LightColor0.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_30 = (-u_xlat32) + 1.0;
    u_xlat16_11 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_11 = u_xlat16_30 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_30 * u_xlat16_11;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_2.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_4 = vs_COLOR0 + _Color;
    u_xlat16_6 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz + u_xlat16_2.xyz;
    u_xlat2.w = u_xlat16_4.w * u_xlat16_6.w;
    u_xlat16_8.xyz = u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_8.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_30 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_33 = (-u_xlat16_30) + _Smoothness;
    u_xlat16_7.xyz = vec3(u_xlat16_30) * u_xlat16_7.xyz;
    u_xlat16_30 = u_xlat16_33 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = (-u_xlat16_8.xyz) + vec3(u_xlat16_30);
    u_xlat16_9.xyz = vec3(u_xlat16_11) * u_xlat16_9.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = u_xlat1.xxx * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_9.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_8.xyz * u_xlat16_5.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat31 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat31) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
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
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
float u_xlat22;
float u_xlat33;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat12.xyz = u_xlat11.xyz * vec3(u_xlat1);
    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1;
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
    u_xlat22 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22 + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_11.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_11.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_38) * u_xlat16_6.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_38);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_10.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat33 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat1) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
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
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
float u_xlat22;
float u_xlat33;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat12.xyz = u_xlat11.xyz * vec3(u_xlat1);
    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1;
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
    u_xlat22 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22 + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_11.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_11.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_38) * u_xlat16_6.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_38);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_9.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_10.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat33 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat1) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
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
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
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
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_5.x = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_5.y = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_5.xy = u_xlat16_5.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_2.xyz = texture(_SphereMap, u_xlat16_5.xy).xyz;
    u_xlat16_1 = vs_COLOR0 + _Color;
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat1.w = u_xlat16_1.w * u_xlat16_3.w;
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
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Occlusion);
    u_xlat16_4.xyz = u_xlat16_7.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_28 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_28) * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat24) * u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_6.xyz * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_4.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
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
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
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
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_6.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
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
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
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
    u_xlat16_7.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
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
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
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
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_10.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_35 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_6.xyz;
    u_xlat16_35 = (-u_xlat16_35) + _Smoothness;
    u_xlat16_35 = u_xlat16_35 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_35);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
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
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
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
    u_xlat16_7.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
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
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_10;
mediump float u_xlat16_27;
float u_xlat28;
bool u_xlatb28;
float u_xlat29;
mediump float u_xlat16_30;
void main()
{
    u_xlat16_0.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = log2(u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Occlusion);
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat16_27 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_27 = u_xlat16_27 + u_xlat16_27;
    u_xlat16_3.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_27)) + (-u_xlat1.xyz);
    u_xlat28 = dot(u_xlat16_3.zxy, (-u_xlat16_3.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(u_xlat28<9.99999975e-06);
#else
    u_xlatb28 = u_xlat28<9.99999975e-06;
#endif
    u_xlat28 = (u_xlatb28) ? u_xlat16_3.z : (-u_xlat16_3.z);
    u_xlat2.z = u_xlat28 * u_xlat16_3.x;
    u_xlat4.x = u_xlat28 * u_xlat16_3.z;
    u_xlat2.xy = (-u_xlat16_3.xy) * u_xlat16_3.yz;
    u_xlat4.yz = (-u_xlat16_3.xy) * u_xlat16_3.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat4.xyz);
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat28 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat28 = sin(u_xlat28);
    u_xlat28 = u_xlat28 * _NormalRand.w;
    u_xlat28 = fract(u_xlat28);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28) + u_xlat16_3.xyz;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * u_xlat2.xyz;
    u_xlat4.z = (-_Smoothness) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb28 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb28 = u_xlat4.z<0.00499999989;
#endif
    u_xlat29 = u_xlat4.z * 8.29800034;
    u_xlat16_27 = (u_xlatb28) ? 0.0 : u_xlat29;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_27);
    u_xlat16_27 = u_xlat16_2.w + -1.0;
    u_xlat16_27 = unity_SpecCube0_HDR.w * u_xlat16_27 + 1.0;
    u_xlat16_27 = u_xlat16_27 * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(u_xlat16_27);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Occlusion);
    u_xlat28 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * vs_TEXCOORD1.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat29 = u_xlat28;
#ifdef UNITY_ADRENO_ES3
    u_xlat29 = min(max(u_xlat29, 0.0), 1.0);
#else
    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
#endif
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat1.xyz = u_xlat2.xyz * (-vec3(u_xlat28)) + u_xlat1.xyz;
    u_xlat28 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat4.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat1.x = u_xlat1.x * 16.0;
    u_xlat16_27 = (-u_xlat29) + 1.0;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_27 * u_xlat16_10;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_5.x = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat2.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat2.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_5.y = dot(u_xlat2.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_5.xy = u_xlat16_5.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_2.xyz = texture(_SphereMap, u_xlat16_5.xy).xyz;
    u_xlat16_4 = vs_COLOR0 + _Color;
    u_xlat16_5 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat2.w = u_xlat16_4.w * u_xlat16_5.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_27 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_30 = (-u_xlat16_27) + _Smoothness;
    u_xlat16_6.xyz = vec3(u_xlat16_27) * u_xlat16_6.xyz;
    u_xlat16_27 = u_xlat16_30 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_27);
    u_xlat16_8.xyz = vec3(u_xlat16_10) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat1.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_6.xyz + u_xlat16_3.xyz;
    u_xlat16_3 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_27 = dot(u_xlat16_3, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_27) * _LightColor0.xyz;
    u_xlat16_6.xyz = vec3(u_xlat28) * u_xlat16_6.xyz;
    u_xlat16_0.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat28 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat28) * u_xlat16_1.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
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
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
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
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
float u_xlat22;
float u_xlat33;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat12.xyz = u_xlat11.xyz * vec3(u_xlat1);
    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1;
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
    u_xlat22 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22 + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_11.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_11.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_38) * u_xlat16_6.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_38);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_38 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_38) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_9.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_10.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat33 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat1) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
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
uniform 	vec4 _MainTex_ST;
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
mediump float u_xlat16_2;
float u_xlat9;
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
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform 	mediump vec4 _FixedAmbientColor;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
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
vec3 u_xlat0;
float u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
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
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
float u_xlat22;
float u_xlat33;
float u_xlat36;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat11.xyz, u_xlat11.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat12.xyz = u_xlat11.xyz * vec3(u_xlat1);
    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat12.xyz);
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
    u_xlat36 = u_xlat0.x * 8.29800034;
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : u_xlat36;
    u_xlat16_2 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_2.x);
    u_xlat16_5.x = u_xlat16_2.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_5.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Occlusion);
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = u_xlat0.x * u_xlat1;
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
    u_xlat22 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat11.x = u_xlat11.x * u_xlat22 + 1.00001001;
    u_xlat0.x = u_xlat11.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_6.x = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat4.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat4.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_6.y = dot(u_xlat4.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_6.xy = u_xlat16_6.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_11.xyz = texture(_SphereMap, u_xlat16_6.xy).xyz;
    u_xlat16_2 = vs_COLOR0 + _Color;
    u_xlat16_4 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz + u_xlat16_11.xyz;
    u_xlat2.w = u_xlat16_2.w * u_xlat16_4.w;
    u_xlat16_7.xyz = u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_38 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = vec3(u_xlat16_38) * u_xlat16_6.xyz;
    u_xlat16_38 = (-u_xlat16_38) + _Smoothness;
    u_xlat16_38 = u_xlat16_38 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_38);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_38 = dot(u_xlat16_4, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vec3(u_xlat16_38) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_9.xyz;
    u_xlat16_9.xyz = max(_FixedAmbientColor.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_4.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_10.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_10.xyz + u_xlat16_4.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * vec3(_Occlusion);
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_9.xyz;
    u_xlat33 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_38 = (-u_xlat1) + 1.0;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_38 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat33) + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
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
  GpuProgramID 78742
Program "vp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
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
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
in highp vec2 vs_TEXCOORD0;
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
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.x = dot(u_xlat1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_6.xyz = texture(_SphereMap, u_xlat16_3.xy).xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_5.xyz;
    u_xlat16_20 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_20) + u_xlat16_5.xyz;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
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
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_7;
mediump float u_xlat16_12;
float u_xlat18;
mediump float u_xlat16_20;
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
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.x = dot(u_xlat1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_2.y = dot(u_xlat1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xyz = texture(_SphereMap, u_xlat16_2.xy).xyz;
    u_xlat16_3.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_5.xyz;
    u_xlat16_20 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat16_2.xyz * vec3(u_xlat16_20) + u_xlat0.xzw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
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
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_7;
mediump float u_xlat16_12;
float u_xlat18;
mediump float u_xlat16_20;
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
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.x = dot(u_xlat1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_2.y = dot(u_xlat1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xyz = texture(_SphereMap, u_xlat16_2.xy).xyz;
    u_xlat16_3.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_5.xyz;
    u_xlat16_20 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat16_2.xyz * vec3(u_xlat16_20) + u_xlat0.xzw;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
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
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
uniform highp sampler2D unity_NHxRoughness;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
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
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_3.x = dot(u_xlat1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_3.y = dot(u_xlat1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_3.xy = u_xlat16_3.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_6.xyz = texture(_SphereMap, u_xlat16_3.xy).xyz;
    u_xlat16_1.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_5.xyz = u_xlat0.xxx * u_xlat16_5.xyz;
    u_xlat16_20 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_20) + u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat0.x = vs_TEXCOORD5;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
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
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_7;
mediump float u_xlat16_12;
float u_xlat18;
mediump float u_xlat16_20;
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
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.x = dot(u_xlat1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_2.y = dot(u_xlat1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xyz = texture(_SphereMap, u_xlat16_2.xy).xyz;
    u_xlat16_3.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_5.xyz;
    u_xlat16_20 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat16_2.xyz * vec3(u_xlat16_20) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xzw;
    u_xlat18 = vs_TEXCOORD5;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
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
    vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    u_xlat0.x = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_2);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump float _Metallic;
uniform 	mediump float _Smoothness;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _SphereMap;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat6;
vec3 u_xlat7;
mediump float u_xlat16_7;
mediump float u_xlat16_12;
float u_xlat18;
mediump float u_xlat16_20;
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
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].x;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].x;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].x;
    u_xlat16_2.x = dot(u_xlat1.xyz, vs_TEXCOORD1.xyz);
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].y;
    u_xlat1.y = hlslcc_mtx4x4unity_MatrixV[1].y;
    u_xlat1.z = hlslcc_mtx4x4unity_MatrixV[2].y;
    u_xlat16_2.y = dot(u_xlat1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_2.xy = u_xlat16_2.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_1.xyz = texture(_SphereMap, u_xlat16_2.xy).xyz;
    u_xlat16_3.xyz = vs_COLOR0.xyz + _Color.xyz;
    u_xlat16_4.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_5.xyz;
    u_xlat16_20 = (-_Metallic) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat16_2.xyz * vec3(u_xlat16_20) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xzw;
    u_xlat18 = vs_TEXCOORD5;
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