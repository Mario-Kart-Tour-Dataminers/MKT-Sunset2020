//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Booster/StandardCustom/Alb_Msa_NoPS" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("Albedo(UV0)", 2D) = "white" { }
_MSA ("MSA Map(UV0)", 2D) = "black" { }
_Occlusion ("Occlusion", Range(0, 1)) = 1
[Header(Booster Reflection Cube Map)] [KeywordEnum(NO,YES,FIXEDCOLOR)] _ReflectionProbeType ("個別リフレクションキューブマップ使用", Float) = 0
_HeuristicReflection ("個別リフレクションキューブマップ", Cube) = "_Skybox" { }
_NormalDiff ("疑似LOD反射の揺らぎ", Range(-1, 1)) = 0
_NormalRand ("疑似LOD乱数値", Vector) = (9993.169,5715.817,4488.509,34.2347)
_FixedReflColor ("単色リフレクションカラー", Color) = (1,1,1,1)
[Space(20)] [Enum(NO,0,YES,128)] _StencilOp ("置き影が落ちなくなる", Float) = 0
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
  GpuProgramID 29161
Program "vp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
mediump vec3 u_xlat16_12;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
mediump float u_xlat16_32;
mediump float u_xlat16_33;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat4.z = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb27 = u_xlat4.z<0.00499999989;
#endif
    u_xlat29 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? 0.0 : u_xlat29;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_32 = u_xlat16_3.z + -1.0;
    u_xlat16_32 = _Occlusion * u_xlat16_32 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_32) * u_xlat16_5.xyz;
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
    u_xlat16_6.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_32 = (-u_xlat29) + 1.0;
    u_xlat16_9 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_9 = u_xlat16_32 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_32 * u_xlat16_9;
    u_xlat16_32 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_33 = (-u_xlat16_32) + 1.0;
    u_xlat16_33 = u_xlat16_3.y + u_xlat16_33;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_12.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_12.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_12.xyz;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_33) + (-u_xlat16_7.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * vec3(u_xlat16_32) + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_5.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_12;
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
    u_xlat16_4.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat0.x = (-u_xlat16_4.y) + 1.0;
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
    u_xlat16_29 = u_xlat16_4.z + -1.0;
    u_xlat16_29 = _Occlusion * u_xlat16_29 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_29) * u_xlat16_5.xyz;
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
    u_xlat16_6 = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_14.x = (-u_xlat16_6) + 1.0;
    u_xlat16_14.x = u_xlat16_4.y + u_xlat16_14.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14.x = min(max(u_xlat16_14.x, 0.0), 1.0);
#else
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_12.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_9.xyz * u_xlat16_12.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_12.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
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
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat8.x = u_xlat8.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyw = u_xlat16_9.xyz * vec3(u_xlat16_6) + u_xlat0.xyw;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_12;
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
    u_xlat16_4.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat0.x = (-u_xlat16_4.y) + 1.0;
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
    u_xlat16_29 = u_xlat16_4.z + -1.0;
    u_xlat16_29 = _Occlusion * u_xlat16_29 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_29) * u_xlat16_5.xyz;
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
    u_xlat16_6 = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_14.x = (-u_xlat16_6) + 1.0;
    u_xlat16_14.x = u_xlat16_4.y + u_xlat16_14.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14.x = min(max(u_xlat16_14.x, 0.0), 1.0);
#else
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_12.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_9.xyz * u_xlat16_12.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_12.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
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
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat8.x = u_xlat8.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xyw = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xyw = u_xlat16_9.xyz * vec3(u_xlat16_6) + u_xlat0.xyw;
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
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
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
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_17;
float u_xlat25;
float u_xlat33;
mediump float u_xlat16_35;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat16_1 = texture(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_35 = u_xlat16_3.z + -1.0;
    u_xlat16_35 = _Occlusion * u_xlat16_35 + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat25 = u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = u_xlat4.xyz * (-vec3(u_xlat33)) + u_xlat0.xyz;
    u_xlat33 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat33) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = (-u_xlat25) + 1.0;
    u_xlat16_11 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_11 = u_xlat16_38 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_38 * u_xlat16_11;
    u_xlat16_38 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.x = (-u_xlat16_38) + 1.0;
    u_xlat16_6.x = u_xlat16_3.y + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_17.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_4.xyz;
    u_xlat16_17.xyz = u_xlat16_3.xxx * u_xlat16_17.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.z = (-u_xlat16_3.y) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_9.xyz = u_xlat0.xxx * u_xlat16_17.xyz + u_xlat16_8.xyz;
    u_xlat16_10.xyz = (-u_xlat16_17.xyz) + u_xlat16_6.xxx;
    u_xlat16_6.xyz = vec3(u_xlat16_11) * u_xlat16_10.xyz + u_xlat16_17.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_6.xyz = u_xlat16_6.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_9.xyz * u_xlat16_5.xyz + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
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
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_17;
mediump vec3 u_xlat16_18;
mediump float u_xlat16_21;
float u_xlat30;
float u_xlat31;
mediump float u_xlat16_31;
float u_xlat32;
mediump float u_xlat16_32;
mediump float u_xlat16_37;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat30 = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = max(u_xlat30, 0.319999993);
    u_xlat16_2.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_31 = (-u_xlat16_2.y) + 1.0;
    u_xlat16_32 = u_xlat16_31 * u_xlat16_31 + 1.5;
    u_xlat30 = u_xlat30 * u_xlat16_32;
    u_xlat32 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat3.xyz = vec3(u_xlat32) * vs_TEXCOORD1.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_11 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_4 = u_xlat16_31 * u_xlat16_11;
    u_xlat16_4 = (-u_xlat16_4) * 0.280000001 + 1.0;
    u_xlat16_21 = u_xlat16_11 * u_xlat16_11 + -1.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_21 + 1.00001001;
    u_xlat30 = u_xlat30 * u_xlat1.x;
    u_xlat30 = u_xlat16_11 / u_xlat30;
    u_xlat30 = u_xlat30 + -9.99999975e-05;
    u_xlat30 = max(u_xlat30, 0.0);
    u_xlat30 = min(u_xlat30, 100.0);
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz;
    u_xlat16_14.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_14.xyz = u_xlat16_2.xxx * u_xlat16_14.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_17.xyz = u_xlat16_6.xyz * u_xlat16_7.xxx;
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_7.x = u_xlat16_2.y + u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat16_2.z + -1.0;
    u_xlat16_8 = _Occlusion * u_xlat16_8 + 1.0;
    u_xlat16_18.xyz = (-u_xlat16_14.xyz) + u_xlat16_7.xxx;
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat16_14.xyz + u_xlat16_17.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_2.xyz;
    u_xlat16_7.xyz = u_xlat16_17.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat31 = dot(u_xlat3.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_37 = (-u_xlat31) + 1.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_14.xyz = vec3(u_xlat16_37) * u_xlat16_18.xyz + u_xlat16_14.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat16_7.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_7.xxx) + (-u_xlat0.xyz);
    u_xlat16_0 = texture(_HeuristicReflection, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_0.w + -1.0;
    u_xlat16_7.x = unity_SpecCube0_HDR.w * u_xlat16_7.x + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_4) * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * u_xlat16_14.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
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
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_17;
mediump vec3 u_xlat16_18;
mediump float u_xlat16_21;
float u_xlat30;
float u_xlat31;
mediump float u_xlat16_31;
float u_xlat32;
mediump float u_xlat16_32;
mediump float u_xlat16_37;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat30 = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = max(u_xlat30, 0.319999993);
    u_xlat16_2.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_31 = (-u_xlat16_2.y) + 1.0;
    u_xlat16_32 = u_xlat16_31 * u_xlat16_31 + 1.5;
    u_xlat30 = u_xlat30 * u_xlat16_32;
    u_xlat32 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat3.xyz = vec3(u_xlat32) * vs_TEXCOORD1.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_11 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_4 = u_xlat16_31 * u_xlat16_11;
    u_xlat16_4 = (-u_xlat16_4) * 0.280000001 + 1.0;
    u_xlat16_21 = u_xlat16_11 * u_xlat16_11 + -1.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_21 + 1.00001001;
    u_xlat30 = u_xlat30 * u_xlat1.x;
    u_xlat30 = u_xlat16_11 / u_xlat30;
    u_xlat30 = u_xlat30 + -9.99999975e-05;
    u_xlat30 = max(u_xlat30, 0.0);
    u_xlat30 = min(u_xlat30, 100.0);
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz;
    u_xlat16_14.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_14.xyz = u_xlat16_2.xxx * u_xlat16_14.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_17.xyz = u_xlat16_6.xyz * u_xlat16_7.xxx;
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_7.x = u_xlat16_2.y + u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat16_2.z + -1.0;
    u_xlat16_8 = _Occlusion * u_xlat16_8 + 1.0;
    u_xlat16_18.xyz = (-u_xlat16_14.xyz) + u_xlat16_7.xxx;
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat16_14.xyz + u_xlat16_17.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_2.xyz;
    u_xlat16_7.xyz = u_xlat16_17.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat31 = dot(u_xlat3.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_37 = (-u_xlat31) + 1.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_14.xyz = vec3(u_xlat16_37) * u_xlat16_18.xyz + u_xlat16_14.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat16_7.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_7.xxx) + (-u_xlat0.xyz);
    u_xlat16_0 = texture(_HeuristicReflection, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_0.w + -1.0;
    u_xlat16_7.x = unity_SpecCube0_HDR.w * u_xlat16_7.x + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_4) * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * u_xlat16_14.xyz + u_xlat1.xyz;
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

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
mediump vec3 u_xlat16_13;
mediump vec3 u_xlat16_17;
float u_xlat30;
bool u_xlatb30;
float u_xlat32;
mediump float u_xlat16_35;
mediump float u_xlat16_36;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat30 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat30<9.99999975e-06);
#else
    u_xlatb30 = u_xlat30<9.99999975e-06;
#endif
    u_xlat30 = (u_xlatb30) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat2.z = u_xlat30 * u_xlat16_1.x;
    u_xlat3.x = u_xlat30 * u_xlat16_1.z;
    u_xlat2.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30) + u_xlat16_1.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat4.z = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb30 = u_xlat4.z<0.00499999989;
#endif
    u_xlat32 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb30) ? 0.0 : u_xlat32;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_35 = u_xlat16_3.z + -1.0;
    u_xlat16_35 = _Occlusion * u_xlat16_35 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_35) * u_xlat16_5.xyz;
    u_xlat30 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * vs_TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat32 = u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat30)) + u_xlat0.xyz;
    u_xlat30 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
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
    u_xlat16_36 = (-u_xlat32) + 1.0;
    u_xlat16_10 = u_xlat16_36 * u_xlat16_36;
    u_xlat16_10 = u_xlat16_36 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_36 * u_xlat16_10;
    u_xlat16_36 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.x = (-u_xlat16_36) + 1.0;
    u_xlat16_7.x = u_xlat16_3.y + u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_13.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_17.xyz = u_xlat16_2.xyz * u_xlat16_13.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_13.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_36) * u_xlat16_2.xyz;
    u_xlat16_17.xyz = u_xlat16_3.xxx * u_xlat16_17.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_9.xyz = (-u_xlat16_17.xyz) + u_xlat16_7.xxx;
    u_xlat16_9.xyz = vec3(u_xlat16_10) * u_xlat16_9.xyz + u_xlat16_17.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_17.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = vec3(u_xlat16_35) * u_xlat16_0.xyz;
    u_xlat16_5.xyz = u_xlat16_9.xyz * u_xlat16_8.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_5.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_17;
float u_xlat18;
float u_xlat24;
float u_xlat26;
bool u_xlatb26;
mediump float u_xlat16_29;
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
    u_xlat16_2.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.x = u_xlat16_2.z + -1.0;
    u_xlat16_1.x = _Occlusion * u_xlat16_1.x + 1.0;
    u_xlat16_9.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_29 = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_4.xyz * vec3(u_xlat16_29);
    u_xlat16_29 = (-u_xlat16_29) + 1.0;
    u_xlat16_29 = u_xlat16_2.y + u_xlat16_29;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat16_2.y) + 1.0;
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + vec3(u_xlat16_29);
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_6.xyz;
    u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat10.xyz = u_xlat8.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat2.xxx;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat26 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat26 = max(u_xlat26, 0.319999993);
    u_xlat3.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat26 = u_xlat26 * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat10.x = u_xlat0.x * u_xlat0.x;
    u_xlat18 = u_xlat10.x * u_xlat10.x + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat18 + 1.00001001;
    u_xlat2.x = u_xlat2.x * u_xlat26;
    u_xlat2.x = u_xlat10.x / u_xlat2.x;
    u_xlat16_29 = u_xlat0.x * u_xlat10.x;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _LightColor0.xyz;
    u_xlat26 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat3.x) + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.xyz = u_xlat16_6.xxx * u_xlat16_7.xyz + u_xlat16_5.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat26) + u_xlat16_9.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb26 = u_xlat0.x<0.00499999989;
#endif
    u_xlat0.x = u_xlat0.x * 8.29800034;
    u_xlat16_9.x = (u_xlatb26) ? 0.0 : u_xlat0.x;
    u_xlat16_17 = dot((-u_xlat8.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_6.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_17)) + (-u_xlat8.xyz);
    u_xlat0.x = dot(u_xlat16_6.zxy, (-u_xlat16_6.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<9.99999975e-06);
#else
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
#endif
    u_xlat0.x = (u_xlatb0) ? u_xlat16_6.z : (-u_xlat16_6.z);
    u_xlat3.z = u_xlat0.x * u_xlat16_6.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_6.z;
    u_xlat3.xy = (-u_xlat16_6.xy) * u_xlat16_6.yz;
    u_xlat0.yz = (-u_xlat16_6.xy) * u_xlat16_6.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_6.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_9.x);
    u_xlat16_9.x = u_xlat16_0.w + -1.0;
    u_xlat16_9.x = unity_SpecCube0_HDR.w * u_xlat16_9.x + 1.0;
    u_xlat16_9.x = u_xlat16_9.x * unity_SpecCube0_HDR.x;
    u_xlat16_9.xyz = u_xlat16_0.xyz * u_xlat16_9.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_9.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_29);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz + u_xlat2.xyz;
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

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_17;
float u_xlat18;
float u_xlat24;
float u_xlat26;
bool u_xlatb26;
mediump float u_xlat16_29;
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
    u_xlat16_2.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.x = u_xlat16_2.z + -1.0;
    u_xlat16_1.x = _Occlusion * u_xlat16_1.x + 1.0;
    u_xlat16_9.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_29 = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_4.xyz * vec3(u_xlat16_29);
    u_xlat16_29 = (-u_xlat16_29) + 1.0;
    u_xlat16_29 = u_xlat16_2.y + u_xlat16_29;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat16_2.y) + 1.0;
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + vec3(u_xlat16_29);
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_6.xyz;
    u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat10.xyz = u_xlat8.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat2.xxx;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat26 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat26 = max(u_xlat26, 0.319999993);
    u_xlat3.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat26 = u_xlat26 * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat10.x = u_xlat0.x * u_xlat0.x;
    u_xlat18 = u_xlat10.x * u_xlat10.x + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat18 + 1.00001001;
    u_xlat2.x = u_xlat2.x * u_xlat26;
    u_xlat2.x = u_xlat10.x / u_xlat2.x;
    u_xlat16_29 = u_xlat0.x * u_xlat10.x;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _LightColor0.xyz;
    u_xlat26 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat3.x) + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.xyz = u_xlat16_6.xxx * u_xlat16_7.xyz + u_xlat16_5.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat26) + u_xlat16_9.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb26 = u_xlat0.x<0.00499999989;
#endif
    u_xlat0.x = u_xlat0.x * 8.29800034;
    u_xlat16_9.x = (u_xlatb26) ? 0.0 : u_xlat0.x;
    u_xlat16_17 = dot((-u_xlat8.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_6.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_17)) + (-u_xlat8.xyz);
    u_xlat0.x = dot(u_xlat16_6.zxy, (-u_xlat16_6.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<9.99999975e-06);
#else
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
#endif
    u_xlat0.x = (u_xlatb0) ? u_xlat16_6.z : (-u_xlat16_6.z);
    u_xlat3.z = u_xlat0.x * u_xlat16_6.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_6.z;
    u_xlat3.xy = (-u_xlat16_6.xy) * u_xlat16_6.yz;
    u_xlat0.yz = (-u_xlat16_6.xy) * u_xlat16_6.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_6.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_9.x);
    u_xlat16_9.x = u_xlat16_0.w + -1.0;
    u_xlat16_9.x = unity_SpecCube0_HDR.w * u_xlat16_9.x + 1.0;
    u_xlat16_9.x = u_xlat16_9.x * unity_SpecCube0_HDR.x;
    u_xlat16_9.xyz = u_xlat16_0.xyz * u_xlat16_9.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_9.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_29);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
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
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
mediump float u_xlat16_15;
float u_xlat23;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat16_1 = texture(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_32 = u_xlat16_3.z + -1.0;
    u_xlat16_32 = _Occlusion * u_xlat16_32 + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_32) * u_xlat16_2.xyz;
    u_xlat30 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat4.xyz = vec3(u_xlat30) * vs_TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat23 = u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = u_xlat4.xyz * (-vec3(u_xlat30)) + u_xlat0.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_5.x = (-u_xlat23) + 1.0;
    u_xlat16_10 = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_10 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_10 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_15 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_15 = u_xlat16_3.y + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xzw = u_xlat16_5.xxx * u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.z = (-u_xlat16_3.y) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_5.xzw;
    u_xlat16_9.xyz = vec3(u_xlat16_15) + (-u_xlat16_7.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_10) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = vec3(u_xlat16_32) * u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_7.xyz * u_xlat16_5.xzw + u_xlat16_2.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_32 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_32) * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat30) * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_8.xyz * u_xlat16_5.xyz + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
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
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_12;
mediump float u_xlat16_22;
float u_xlat30;
mediump float u_xlat16_31;
float u_xlat32;
mediump float u_xlat16_32;
float u_xlat33;
mediump float u_xlat16_33;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat30 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = max(u_xlat30, 0.319999993);
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_32 = (-u_xlat16_3.y) + 1.0;
    u_xlat16_33 = u_xlat16_32 * u_xlat16_32 + 1.5;
    u_xlat30 = u_xlat30 * u_xlat16_33;
    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_12 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_31 = u_xlat16_32 * u_xlat16_12;
    u_xlat16_31 = (-u_xlat16_31) * 0.280000001 + 1.0;
    u_xlat16_22 = u_xlat16_12 * u_xlat16_12 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat16_22 + 1.00001001;
    u_xlat30 = u_xlat30 * u_xlat2.x;
    u_xlat30 = u_xlat16_12 / u_xlat30;
    u_xlat30 = u_xlat30 + -9.99999975e-05;
    u_xlat30 = max(u_xlat30, 0.0);
    u_xlat30 = min(u_xlat30, 100.0);
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_37 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_8.xyz = u_xlat16_6.xyz * vec3(u_xlat16_37);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = u_xlat16_3.y + u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_3.z + -1.0;
    u_xlat16_38 = _Occlusion * u_xlat16_38 + 1.0;
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_37);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = vs_TEXCOORD1.xyz;
    u_xlat3.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = vec3(u_xlat16_38) * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat32 = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat16_37 = (-u_xlat32) + 1.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_7.xyz = vec3(u_xlat16_37) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30) + u_xlat16_1.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat16_0 = texture(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_1.x = u_xlat16_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(u_xlat16_38) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_31);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
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
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_12;
mediump float u_xlat16_22;
float u_xlat30;
mediump float u_xlat16_31;
float u_xlat32;
mediump float u_xlat16_32;
float u_xlat33;
mediump float u_xlat16_33;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat30 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = max(u_xlat30, 0.319999993);
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_32 = (-u_xlat16_3.y) + 1.0;
    u_xlat16_33 = u_xlat16_32 * u_xlat16_32 + 1.5;
    u_xlat30 = u_xlat30 * u_xlat16_33;
    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_12 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_31 = u_xlat16_32 * u_xlat16_12;
    u_xlat16_31 = (-u_xlat16_31) * 0.280000001 + 1.0;
    u_xlat16_22 = u_xlat16_12 * u_xlat16_12 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat16_22 + 1.00001001;
    u_xlat30 = u_xlat30 * u_xlat2.x;
    u_xlat30 = u_xlat16_12 / u_xlat30;
    u_xlat30 = u_xlat30 + -9.99999975e-05;
    u_xlat30 = max(u_xlat30, 0.0);
    u_xlat30 = min(u_xlat30, 100.0);
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_37 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_8.xyz = u_xlat16_6.xyz * vec3(u_xlat16_37);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = u_xlat16_3.y + u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_3.z + -1.0;
    u_xlat16_38 = _Occlusion * u_xlat16_38 + 1.0;
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_37);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = vs_TEXCOORD1.xyz;
    u_xlat3.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = vec3(u_xlat16_38) * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat32 = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat16_37 = (-u_xlat32) + 1.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_7.xyz = vec3(u_xlat16_37) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30) + u_xlat16_1.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat16_0 = texture(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_1.x = u_xlat16_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(u_xlat16_38) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_31);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat2.xyz;
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

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_15;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat4.z = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb27 = u_xlat4.z<0.00499999989;
#endif
    u_xlat29 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? 0.0 : u_xlat29;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_32 = u_xlat16_3.z + -1.0;
    u_xlat16_32 = _Occlusion * u_xlat16_32 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_32) * u_xlat16_5.xyz;
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
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_6.x = (-u_xlat29) + 1.0;
    u_xlat16_9 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_9 = u_xlat16_6.x * u_xlat16_9;
    u_xlat16_9 = u_xlat16_6.x * u_xlat16_9;
    u_xlat16_6.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_15 = (-u_xlat16_6.x) + 1.0;
    u_xlat16_15 = u_xlat16_3.y + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_12.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_12.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_12.xyz;
    u_xlat16_6.xzw = u_xlat16_6.xxx * u_xlat16_2.xyz;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_15) + (-u_xlat16_7.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xzw;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_8.xyz = u_xlat16_8.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = vec3(u_xlat16_32) * u_xlat16_0.xyz;
    u_xlat16_5.xyz = u_xlat16_8.xyz * u_xlat16_6.xzw + u_xlat16_5.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_32 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_32) * _LightColor0.xyz;
    u_xlat16_6.xyz = vec3(u_xlat27) * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_5.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
float u_xlat12;
float u_xlat22;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
float u_xlat32;
float u_xlat33;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat30 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = max(u_xlat30, 0.319999993);
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat32 = (-u_xlat16_3.y) + 1.0;
    u_xlat33 = u_xlat32 * u_xlat32 + 1.5;
    u_xlat30 = u_xlat30 * u_xlat33;
    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat12 = u_xlat32 * u_xlat32;
    u_xlat22 = u_xlat12 * u_xlat12 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat22 + 1.00001001;
    u_xlat30 = u_xlat30 * u_xlat2.x;
    u_xlat30 = u_xlat12 / u_xlat30;
    u_xlat16_31 = u_xlat32 * u_xlat12;
    u_xlat16_31 = (-u_xlat16_31) * 0.280000001 + 1.0;
    u_xlat30 = u_xlat30 + -9.99999975e-05;
    u_xlat30 = max(u_xlat30, 0.0);
    u_xlat30 = min(u_xlat30, 100.0);
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_37 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_8.xyz = u_xlat16_6.xyz * vec3(u_xlat16_37);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = u_xlat16_3.y + u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_3.z + -1.0;
    u_xlat16_38 = _Occlusion * u_xlat16_38 + 1.0;
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_37);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = vs_TEXCOORD1.xyz;
    u_xlat3.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = vec3(u_xlat16_38) * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_37 = (-u_xlat3.x) + 1.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_7.xyz = vec3(u_xlat16_37) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30) + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat32<0.00499999989);
#else
    u_xlatb30 = u_xlat32<0.00499999989;
#endif
    u_xlat32 = u_xlat32 * 8.29800034;
    u_xlat16_1.x = (u_xlatb30) ? 0.0 : u_xlat32;
    u_xlat16_11 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_11 = u_xlat16_11 + u_xlat16_11;
    u_xlat16_8.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_11)) + (-u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat16_8.zxy, (-u_xlat16_8.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<9.99999975e-06);
#else
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
#endif
    u_xlat0.x = (u_xlatb0) ? u_xlat16_8.z : (-u_xlat16_8.z);
    u_xlat3.z = u_xlat0.x * u_xlat16_8.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_8.z;
    u_xlat3.xy = (-u_xlat16_8.xy) * u_xlat16_8.yz;
    u_xlat0.yz = (-u_xlat16_8.xy) * u_xlat16_8.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_8.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(u_xlat16_38) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_31);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat2.xyz;
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

uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
float u_xlat12;
float u_xlat22;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
float u_xlat32;
float u_xlat33;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat30 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = max(u_xlat30, 0.319999993);
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat32 = (-u_xlat16_3.y) + 1.0;
    u_xlat33 = u_xlat32 * u_xlat32 + 1.5;
    u_xlat30 = u_xlat30 * u_xlat33;
    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat12 = u_xlat32 * u_xlat32;
    u_xlat22 = u_xlat12 * u_xlat12 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat22 + 1.00001001;
    u_xlat30 = u_xlat30 * u_xlat2.x;
    u_xlat30 = u_xlat12 / u_xlat30;
    u_xlat16_31 = u_xlat32 * u_xlat12;
    u_xlat16_31 = (-u_xlat16_31) * 0.280000001 + 1.0;
    u_xlat30 = u_xlat30 + -9.99999975e-05;
    u_xlat30 = max(u_xlat30, 0.0);
    u_xlat30 = min(u_xlat30, 100.0);
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_37 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_8.xyz = u_xlat16_6.xyz * vec3(u_xlat16_37);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = u_xlat16_3.y + u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_3.z + -1.0;
    u_xlat16_38 = _Occlusion * u_xlat16_38 + 1.0;
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_37);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = vs_TEXCOORD1.xyz;
    u_xlat3.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = vec3(u_xlat16_38) * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_37 = (-u_xlat3.x) + 1.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_7.xyz = vec3(u_xlat16_37) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30) + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat32<0.00499999989);
#else
    u_xlatb30 = u_xlat32<0.00499999989;
#endif
    u_xlat32 = u_xlat32 * 8.29800034;
    u_xlat16_1.x = (u_xlatb30) ? 0.0 : u_xlat32;
    u_xlat16_11 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_11 = u_xlat16_11 + u_xlat16_11;
    u_xlat16_8.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_11)) + (-u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat16_8.zxy, (-u_xlat16_8.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<9.99999975e-06);
#else
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
#endif
    u_xlat0.x = (u_xlatb0) ? u_xlat16_8.z : (-u_xlat16_8.z);
    u_xlat3.z = u_xlat0.x * u_xlat16_8.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_8.z;
    u_xlat3.xy = (-u_xlat16_8.xy) * u_xlat16_8.yz;
    u_xlat0.yz = (-u_xlat16_8.xy) * u_xlat16_8.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_8.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(u_xlat16_38) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_31);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_17;
float u_xlat25;
float u_xlat33;
mediump float u_xlat16_35;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat16_1 = texture(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_35 = u_xlat16_3.z + -1.0;
    u_xlat16_35 = _Occlusion * u_xlat16_35 + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat25 = u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = u_xlat4.xyz * (-vec3(u_xlat33)) + u_xlat0.xyz;
    u_xlat33 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat33) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = (-u_xlat25) + 1.0;
    u_xlat16_11 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_11 = u_xlat16_38 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_38 * u_xlat16_11;
    u_xlat16_38 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.x = (-u_xlat16_38) + 1.0;
    u_xlat16_6.x = u_xlat16_3.y + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_17.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_4.xyz;
    u_xlat16_17.xyz = u_xlat16_3.xxx * u_xlat16_17.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.z = (-u_xlat16_3.y) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_9.xyz = u_xlat0.xxx * u_xlat16_17.xyz + u_xlat16_8.xyz;
    u_xlat16_10.xyz = (-u_xlat16_17.xyz) + u_xlat16_6.xxx;
    u_xlat16_6.xyz = vec3(u_xlat16_11) * u_xlat16_10.xyz + u_xlat16_17.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_9.xyz * u_xlat16_5.xyz + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump float u_xlat16_10;
mediump vec3 u_xlat16_13;
mediump vec3 u_xlat16_16;
mediump vec3 u_xlat16_17;
mediump float u_xlat16_19;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_28;
float u_xlat29;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat27 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat1.xyz;
    u_xlat27 = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 0.319999993);
    u_xlat16_2.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_28 = (-u_xlat16_2.y) + 1.0;
    u_xlat16_29 = u_xlat16_28 * u_xlat16_28 + 1.5;
    u_xlat27 = u_xlat27 * u_xlat16_29;
    u_xlat29 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat3.xyz = vec3(u_xlat29) * vs_TEXCOORD1.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_10 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_4 = u_xlat16_28 * u_xlat16_10;
    u_xlat16_4 = (-u_xlat16_4) * 0.280000001 + 1.0;
    u_xlat16_19 = u_xlat16_10 * u_xlat16_10 + -1.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_19 + 1.00001001;
    u_xlat27 = u_xlat27 * u_xlat1.x;
    u_xlat27 = u_xlat16_10 / u_xlat27;
    u_xlat27 = u_xlat27 + -9.99999975e-05;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 100.0);
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz;
    u_xlat16_13.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_13.xyz = u_xlat16_2.xxx * u_xlat16_13.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_16.xyz = u_xlat16_6.xyz * u_xlat16_7.xxx;
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_7.x = u_xlat16_2.y + u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat16_2.z + -1.0;
    u_xlat16_8 = _Occlusion * u_xlat16_8 + 1.0;
    u_xlat16_17.xyz = (-u_xlat16_13.xyz) + u_xlat16_7.xxx;
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat16_13.xyz + u_xlat16_16.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat27 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat28 = dot(u_xlat3.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat16_7.x = (-u_xlat28) + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_13.xyz = u_xlat16_7.xxx * u_xlat16_17.xyz + u_xlat16_13.xyz;
    u_xlat16_2.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_17.xyz = u_xlat16_2.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_17.xyz = vec3(u_xlat16_8) * u_xlat16_17.xyz;
    u_xlat16_7.xyz = u_xlat16_16.xyz * u_xlat16_17.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27) + u_xlat16_7.xyz;
    u_xlat16_7.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_7.xxx) + (-u_xlat0.xyz);
    u_xlat16_0 = texture(_HeuristicReflection, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_0.w + -1.0;
    u_xlat16_7.x = unity_SpecCube0_HDR.w * u_xlat16_7.x + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_4) * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * u_xlat16_13.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump float u_xlat16_10;
mediump vec3 u_xlat16_13;
mediump vec3 u_xlat16_16;
mediump vec3 u_xlat16_17;
mediump float u_xlat16_19;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_28;
float u_xlat29;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat27 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat1.xyz;
    u_xlat27 = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 0.319999993);
    u_xlat16_2.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_28 = (-u_xlat16_2.y) + 1.0;
    u_xlat16_29 = u_xlat16_28 * u_xlat16_28 + 1.5;
    u_xlat27 = u_xlat27 * u_xlat16_29;
    u_xlat29 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat3.xyz = vec3(u_xlat29) * vs_TEXCOORD1.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_10 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_4 = u_xlat16_28 * u_xlat16_10;
    u_xlat16_4 = (-u_xlat16_4) * 0.280000001 + 1.0;
    u_xlat16_19 = u_xlat16_10 * u_xlat16_10 + -1.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_19 + 1.00001001;
    u_xlat27 = u_xlat27 * u_xlat1.x;
    u_xlat27 = u_xlat16_10 / u_xlat27;
    u_xlat27 = u_xlat27 + -9.99999975e-05;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 100.0);
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz;
    u_xlat16_13.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_13.xyz = u_xlat16_2.xxx * u_xlat16_13.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_16.xyz = u_xlat16_6.xyz * u_xlat16_7.xxx;
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_7.x = u_xlat16_2.y + u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat16_2.z + -1.0;
    u_xlat16_8 = _Occlusion * u_xlat16_8 + 1.0;
    u_xlat16_17.xyz = (-u_xlat16_13.xyz) + u_xlat16_7.xxx;
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat16_13.xyz + u_xlat16_16.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat27 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat28 = dot(u_xlat3.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat16_7.x = (-u_xlat28) + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_13.xyz = u_xlat16_7.xxx * u_xlat16_17.xyz + u_xlat16_13.xyz;
    u_xlat16_2.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_17.xyz = u_xlat16_2.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_17.xyz = vec3(u_xlat16_8) * u_xlat16_17.xyz;
    u_xlat16_7.xyz = u_xlat16_16.xyz * u_xlat16_17.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27) + u_xlat16_7.xyz;
    u_xlat16_7.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_7.xxx) + (-u_xlat0.xyz);
    u_xlat16_0 = texture(_HeuristicReflection, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_0.w + -1.0;
    u_xlat16_7.x = unity_SpecCube0_HDR.w * u_xlat16_7.x + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_4) * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * u_xlat16_13.xyz + u_xlat1.xyz;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
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
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
mediump vec3 u_xlat16_13;
mediump vec3 u_xlat16_17;
float u_xlat30;
bool u_xlatb30;
float u_xlat32;
mediump float u_xlat16_35;
mediump float u_xlat16_36;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat30 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat30<9.99999975e-06);
#else
    u_xlatb30 = u_xlat30<9.99999975e-06;
#endif
    u_xlat30 = (u_xlatb30) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat2.z = u_xlat30 * u_xlat16_1.x;
    u_xlat3.x = u_xlat30 * u_xlat16_1.z;
    u_xlat2.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30) + u_xlat16_1.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat4.z = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb30 = u_xlat4.z<0.00499999989;
#endif
    u_xlat32 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb30) ? 0.0 : u_xlat32;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_35 = u_xlat16_3.z + -1.0;
    u_xlat16_35 = _Occlusion * u_xlat16_35 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_35) * u_xlat16_5.xyz;
    u_xlat30 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * vs_TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat32 = u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat30)) + u_xlat0.xyz;
    u_xlat30 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
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
    u_xlat16_36 = (-u_xlat32) + 1.0;
    u_xlat16_10 = u_xlat16_36 * u_xlat16_36;
    u_xlat16_10 = u_xlat16_36 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_36 * u_xlat16_10;
    u_xlat16_36 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.x = (-u_xlat16_36) + 1.0;
    u_xlat16_7.x = u_xlat16_3.y + u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_13.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_17.xyz = u_xlat16_2.xyz * u_xlat16_13.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_13.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_36) * u_xlat16_2.xyz;
    u_xlat16_17.xyz = u_xlat16_3.xxx * u_xlat16_17.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_9.xyz = (-u_xlat16_17.xyz) + u_xlat16_7.xxx;
    u_xlat16_9.xyz = vec3(u_xlat16_10) * u_xlat16_9.xyz + u_xlat16_17.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_17.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = vec3(u_xlat16_35) * u_xlat16_9.xyz;
    u_xlat16_5.xyz = u_xlat16_9.xyz * u_xlat16_8.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_5.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
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
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
mediump float u_xlat16_42;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat13.xyz = u_xlat12.xyz * vec3(u_xlat1);
    u_xlat12.xyz = u_xlat12.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
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
    u_xlat16_4.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat0.x = (-u_xlat16_4.y) + 1.0;
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
    u_xlat16_41 = u_xlat16_4.z + -1.0;
    u_xlat16_41 = _Occlusion * u_xlat16_41 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz;
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_6.x = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_6.x = (-u_xlat16_6.x) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xxx;
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
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_12.xyz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz * u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_42 = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_9.xyz = vec3(u_xlat16_42) * u_xlat16_8.xyz;
    u_xlat16_42 = (-u_xlat16_42) + 1.0;
    u_xlat16_42 = u_xlat16_4.y + u_xlat16_42;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_42 = min(max(u_xlat16_42, 0.0), 1.0);
#else
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_42);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_9.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_11.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_11.xyz = vec3(u_xlat16_41) * u_xlat16_11.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_11.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat1) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_9.xyz;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
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
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
mediump float u_xlat16_42;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat13.xyz = u_xlat12.xyz * vec3(u_xlat1);
    u_xlat12.xyz = u_xlat12.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
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
    u_xlat16_4.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat0.x = (-u_xlat16_4.y) + 1.0;
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
    u_xlat16_41 = u_xlat16_4.z + -1.0;
    u_xlat16_41 = _Occlusion * u_xlat16_41 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz;
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_6.x = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_6.x = (-u_xlat16_6.x) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xxx;
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
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_12.xyz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz * u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_42 = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_9.xyz = vec3(u_xlat16_42) * u_xlat16_8.xyz;
    u_xlat16_42 = (-u_xlat16_42) + 1.0;
    u_xlat16_42 = u_xlat16_4.y + u_xlat16_42;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_42 = min(max(u_xlat16_42, 0.0), 1.0);
#else
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_42);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_9.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_11.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_11.xyz = vec3(u_xlat16_41) * u_xlat16_11.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_11.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat1) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_9.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
float u_xlat27;
mediump float u_xlat16_27;
mediump float u_xlat16_36;
mediump float u_xlat16_38;
float u_xlat39;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_36 = u_xlat16_3.z + -1.0;
    u_xlat16_36 = _Occlusion * u_xlat16_36 + 1.0;
    u_xlat16_0.xyz = vec3(u_xlat16_36) * u_xlat16_0.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat16_2.x = dot((-u_xlat4.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat4.xyz);
    u_xlat16_1 = texture(_HeuristicReflection, u_xlat16_2.xyz);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = vec3(u_xlat16_36) * u_xlat16_2.xyz;
    u_xlat27 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * vs_TEXCOORD1.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat39 = u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat4.xyz = u_xlat5.xyz * (-vec3(u_xlat27)) + u_xlat4.xyz;
    u_xlat27 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat27 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = u_xlat27 * u_xlat27;
    u_xlat4.x = u_xlat27 * u_xlat27;
    u_xlat16_36 = (-u_xlat39) + 1.0;
    u_xlat16_27 = u_xlat16_36 * u_xlat16_36;
    u_xlat16_27 = u_xlat16_36 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_36 * u_xlat16_27;
    u_xlat16_36 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_38 = (-u_xlat16_36) + 1.0;
    u_xlat16_38 = u_xlat16_38 + u_xlat16_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat16_9.xyz = vec3(u_xlat16_36) * u_xlat16_5.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat4.z = (-u_xlat16_3.y) + 1.0;
    u_xlat3 = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat3 = u_xlat3 * 16.0;
    u_xlat16_10.xyz = vec3(u_xlat3) * u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat16_11.xyz = vec3(u_xlat16_38) + (-u_xlat16_8.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_27) * u_xlat16_11.xyz + u_xlat16_8.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_9.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_10.xyz * u_xlat16_6.xyz + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
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
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat12;
vec3 u_xlat13;
mediump float u_xlat16_13;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_27 = u_xlat16_3.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_29 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz;
    u_xlat16_29 = (-u_xlat16_29) + 1.0;
    u_xlat16_29 = u_xlat16_29 + u_xlat16_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.y) + 1.0;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat16_29);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat4.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat4.xxx;
    u_xlat4.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat13.xyz;
    u_xlat31 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat31 = max(u_xlat31, 0.319999993);
    u_xlat16_5.x = u_xlat16_3.x * u_xlat16_3.x + 1.5;
    u_xlat31 = u_xlat31 * u_xlat16_5.x;
    u_xlat5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_13 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_29 = u_xlat16_3.x * u_xlat16_13;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat16_3.x = u_xlat16_13 * u_xlat16_13 + -1.0;
    u_xlat3.x = u_xlat4.x * u_xlat16_3.x + 1.00001001;
    u_xlat3.x = u_xlat3.x * u_xlat31;
    u_xlat3.x = u_xlat16_13 / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + -9.99999975e-05;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = min(u_xlat3.x, 100.0);
    u_xlat4.xyz = u_xlat3.xxx * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _LightColor0.xyz;
    u_xlat3.x = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat31 = dot(u_xlat5.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_7.x = (-u_xlat31) + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_2.xyz = u_xlat16_7.xxx * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat3.xxx + u_xlat16_0.xyz;
    u_xlat16_0.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_0.xxx) + (-u_xlat12.xyz);
    u_xlat16_1 = texture(_HeuristicReflection, u_xlat16_0.xyz);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_29);
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
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
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat12;
vec3 u_xlat13;
mediump float u_xlat16_13;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_27 = u_xlat16_3.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_29 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz;
    u_xlat16_29 = (-u_xlat16_29) + 1.0;
    u_xlat16_29 = u_xlat16_29 + u_xlat16_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.y) + 1.0;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat16_29);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat4.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat4.xxx;
    u_xlat4.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat13.xyz;
    u_xlat31 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat31 = max(u_xlat31, 0.319999993);
    u_xlat16_5.x = u_xlat16_3.x * u_xlat16_3.x + 1.5;
    u_xlat31 = u_xlat31 * u_xlat16_5.x;
    u_xlat5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_13 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_29 = u_xlat16_3.x * u_xlat16_13;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat16_3.x = u_xlat16_13 * u_xlat16_13 + -1.0;
    u_xlat3.x = u_xlat4.x * u_xlat16_3.x + 1.00001001;
    u_xlat3.x = u_xlat3.x * u_xlat31;
    u_xlat3.x = u_xlat16_13 / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + -9.99999975e-05;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = min(u_xlat3.x, 100.0);
    u_xlat4.xyz = u_xlat3.xxx * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _LightColor0.xyz;
    u_xlat3.x = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat31 = dot(u_xlat5.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_7.x = (-u_xlat31) + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_2.xyz = u_xlat16_7.xxx * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat3.xxx + u_xlat16_0.xyz;
    u_xlat16_0.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_0.xxx) + (-u_xlat12.xyz);
    u_xlat16_1 = texture(_HeuristicReflection, u_xlat16_0.xyz);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_29);
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_18;
float u_xlat33;
bool u_xlatb33;
float u_xlat35;
mediump float u_xlat16_38;
mediump float u_xlat16_39;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat33 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<9.99999975e-06);
#else
    u_xlatb33 = u_xlat33<9.99999975e-06;
#endif
    u_xlat33 = (u_xlatb33) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat2.z = u_xlat33 * u_xlat16_1.x;
    u_xlat3.x = u_xlat33 * u_xlat16_1.z;
    u_xlat2.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat33 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * _NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat33) + u_xlat16_1.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat2.xyz;
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat4.z = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb33 = u_xlat4.z<0.00499999989;
#endif
    u_xlat35 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb33) ? 0.0 : u_xlat35;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_38 = u_xlat16_3.z + -1.0;
    u_xlat16_38 = _Occlusion * u_xlat16_38 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_38) * u_xlat16_5.xyz;
    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat35 = u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat35 = min(max(u_xlat35, 0.0), 1.0);
#else
    u_xlat35 = clamp(u_xlat35, 0.0, 1.0);
#endif
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat33)) + u_xlat0.xyz;
    u_xlat33 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat33) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_39 = (-u_xlat35) + 1.0;
    u_xlat16_11 = u_xlat16_39 * u_xlat16_39;
    u_xlat16_11 = u_xlat16_39 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_39 * u_xlat16_11;
    u_xlat16_39 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.x = (-u_xlat16_39) + 1.0;
    u_xlat16_7.x = u_xlat16_3.y + u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_14.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_18.xyz = u_xlat16_2.xyz * u_xlat16_14.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_14.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_39) * u_xlat16_2.xyz;
    u_xlat16_18.xyz = u_xlat16_3.xxx * u_xlat16_18.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_9.xyz = (-u_xlat16_18.xyz) + u_xlat16_7.xxx;
    u_xlat16_9.xyz = vec3(u_xlat16_11) * u_xlat16_9.xyz + u_xlat16_18.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_18.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_39 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_39 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_39);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_39) + u_xlat16_9.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_9.xyz = vec3(u_xlat16_38) * u_xlat16_9.xyz;
    u_xlat16_5.xyz = u_xlat16_9.xyz * u_xlat16_8.xyz + u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_5.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
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
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat22;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_27 = u_xlat16_3.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_29 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz;
    u_xlat16_29 = (-u_xlat16_29) + 1.0;
    u_xlat16_29 = u_xlat16_29 + u_xlat16_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat16_3.y) + 1.0;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat16_29);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat4.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat4.xxx;
    u_xlat4.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat13.xyz;
    u_xlat31 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat31 = max(u_xlat31, 0.319999993);
    u_xlat5.x = u_xlat3.x * u_xlat3.x + 1.5;
    u_xlat31 = u_xlat31 * u_xlat5.x;
    u_xlat5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat13.x = u_xlat3.x * u_xlat3.x;
    u_xlat22 = u_xlat13.x * u_xlat13.x + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat22 + 1.00001001;
    u_xlat4.x = u_xlat4.x * u_xlat31;
    u_xlat4.x = u_xlat13.x / u_xlat4.x;
    u_xlat16_29 = u_xlat3.x * u_xlat13.x;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _LightColor0.xyz;
    u_xlat31 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = (-u_xlat5.x) + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_2.xyz = u_xlat16_7.xxx * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat3.x<0.00499999989);
#else
    u_xlatb31 = u_xlat3.x<0.00499999989;
#endif
    u_xlat3.x = u_xlat3.x * 8.29800034;
    u_xlat16_0.x = (u_xlatb31) ? 0.0 : u_xlat3.x;
    u_xlat16_9 = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_9 = u_xlat16_9 + u_xlat16_9;
    u_xlat16_7.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_9)) + (-u_xlat12.xyz);
    u_xlat3.x = dot(u_xlat16_7.zxy, (-u_xlat16_7.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<9.99999975e-06);
#else
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
#endif
    u_xlat3.x = (u_xlatb3) ? u_xlat16_7.z : (-u_xlat16_7.z);
    u_xlat5.z = u_xlat3.x * u_xlat16_7.x;
    u_xlat3.x = u_xlat3.x * u_xlat16_7.z;
    u_xlat5.xy = (-u_xlat16_7.xy) * u_xlat16_7.yz;
    u_xlat3.yz = (-u_xlat16_7.xy) * u_xlat16_7.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat5.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_29);
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
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
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat22;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_27 = u_xlat16_3.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_29 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz;
    u_xlat16_29 = (-u_xlat16_29) + 1.0;
    u_xlat16_29 = u_xlat16_29 + u_xlat16_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat16_3.y) + 1.0;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat16_29);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat4.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat4.xxx;
    u_xlat4.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat13.xyz;
    u_xlat31 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat31 = max(u_xlat31, 0.319999993);
    u_xlat5.x = u_xlat3.x * u_xlat3.x + 1.5;
    u_xlat31 = u_xlat31 * u_xlat5.x;
    u_xlat5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat13.x = u_xlat3.x * u_xlat3.x;
    u_xlat22 = u_xlat13.x * u_xlat13.x + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat22 + 1.00001001;
    u_xlat4.x = u_xlat4.x * u_xlat31;
    u_xlat4.x = u_xlat13.x / u_xlat4.x;
    u_xlat16_29 = u_xlat3.x * u_xlat13.x;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _LightColor0.xyz;
    u_xlat31 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = (-u_xlat5.x) + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_2.xyz = u_xlat16_7.xxx * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat3.x<0.00499999989);
#else
    u_xlatb31 = u_xlat3.x<0.00499999989;
#endif
    u_xlat3.x = u_xlat3.x * 8.29800034;
    u_xlat16_0.x = (u_xlatb31) ? 0.0 : u_xlat3.x;
    u_xlat16_9 = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_9 = u_xlat16_9 + u_xlat16_9;
    u_xlat16_7.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_9)) + (-u_xlat12.xyz);
    u_xlat3.x = dot(u_xlat16_7.zxy, (-u_xlat16_7.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<9.99999975e-06);
#else
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
#endif
    u_xlat3.x = (u_xlatb3) ? u_xlat16_7.z : (-u_xlat16_7.z);
    u_xlat5.z = u_xlat3.x * u_xlat16_7.x;
    u_xlat3.x = u_xlat3.x * u_xlat16_7.z;
    u_xlat5.xy = (-u_xlat16_7.xy) * u_xlat16_7.yz;
    u_xlat3.yz = (-u_xlat16_7.xy) * u_xlat16_7.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat5.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_29);
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
mediump float u_xlat16_15;
float u_xlat23;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat16_1 = texture(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_32 = u_xlat16_3.z + -1.0;
    u_xlat16_32 = _Occlusion * u_xlat16_32 + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_32) * u_xlat16_2.xyz;
    u_xlat30 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat4.xyz = vec3(u_xlat30) * vs_TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat23 = u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = u_xlat4.xyz * (-vec3(u_xlat30)) + u_xlat0.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_5.x = (-u_xlat23) + 1.0;
    u_xlat16_10 = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_10 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_10 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_15 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_15 = u_xlat16_3.y + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xzw = u_xlat16_5.xxx * u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.z = (-u_xlat16_3.y) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_5.xzw;
    u_xlat16_9.xyz = vec3(u_xlat16_15) + (-u_xlat16_7.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_10) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_32) * u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_7.xyz * u_xlat16_5.xzw + u_xlat16_2.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_32 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_32) * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat30) * u_xlat16_5.xyz;
    SV_Target0.xyz = u_xlat16_8.xyz * u_xlat16_5.xyz + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_12;
mediump float u_xlat16_22;
float u_xlat30;
mediump float u_xlat16_31;
float u_xlat32;
mediump float u_xlat16_32;
float u_xlat33;
mediump float u_xlat16_33;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat30 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = max(u_xlat30, 0.319999993);
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_32 = (-u_xlat16_3.y) + 1.0;
    u_xlat16_33 = u_xlat16_32 * u_xlat16_32 + 1.5;
    u_xlat30 = u_xlat30 * u_xlat16_33;
    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_12 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_31 = u_xlat16_32 * u_xlat16_12;
    u_xlat16_31 = (-u_xlat16_31) * 0.280000001 + 1.0;
    u_xlat16_22 = u_xlat16_12 * u_xlat16_12 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat16_22 + 1.00001001;
    u_xlat30 = u_xlat30 * u_xlat2.x;
    u_xlat30 = u_xlat16_12 / u_xlat30;
    u_xlat30 = u_xlat30 + -9.99999975e-05;
    u_xlat30 = max(u_xlat30, 0.0);
    u_xlat30 = min(u_xlat30, 100.0);
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_37 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_8.xyz = u_xlat16_6.xyz * vec3(u_xlat16_37);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = u_xlat16_3.y + u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_3.z + -1.0;
    u_xlat16_38 = _Occlusion * u_xlat16_38 + 1.0;
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_37);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat32 = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat32) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_8.xyz * u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat16_7.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_7.xxx) + (-u_xlat0.xyz);
    u_xlat16_0 = texture(_HeuristicReflection, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_0.w + -1.0;
    u_xlat16_7.x = unity_SpecCube0_HDR.w * u_xlat16_7.x + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_12;
mediump float u_xlat16_22;
float u_xlat30;
mediump float u_xlat16_31;
float u_xlat32;
mediump float u_xlat16_32;
float u_xlat33;
mediump float u_xlat16_33;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat30 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = max(u_xlat30, 0.319999993);
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_32 = (-u_xlat16_3.y) + 1.0;
    u_xlat16_33 = u_xlat16_32 * u_xlat16_32 + 1.5;
    u_xlat30 = u_xlat30 * u_xlat16_33;
    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_12 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_31 = u_xlat16_32 * u_xlat16_12;
    u_xlat16_31 = (-u_xlat16_31) * 0.280000001 + 1.0;
    u_xlat16_22 = u_xlat16_12 * u_xlat16_12 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat16_22 + 1.00001001;
    u_xlat30 = u_xlat30 * u_xlat2.x;
    u_xlat30 = u_xlat16_12 / u_xlat30;
    u_xlat30 = u_xlat30 + -9.99999975e-05;
    u_xlat30 = max(u_xlat30, 0.0);
    u_xlat30 = min(u_xlat30, 100.0);
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_37 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_8.xyz = u_xlat16_6.xyz * vec3(u_xlat16_37);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = u_xlat16_3.y + u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_3.z + -1.0;
    u_xlat16_38 = _Occlusion * u_xlat16_38 + 1.0;
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_37);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat32 = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat32) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_8.xyz * u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat16_7.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_7.xxx) + (-u_xlat0.xyz);
    u_xlat16_0 = texture(_HeuristicReflection, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_0.w + -1.0;
    u_xlat16_7.x = unity_SpecCube0_HDR.w * u_xlat16_7.x + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
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
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_15;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat4.z = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb27 = u_xlat4.z<0.00499999989;
#endif
    u_xlat29 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? 0.0 : u_xlat29;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_32 = u_xlat16_3.z + -1.0;
    u_xlat16_32 = _Occlusion * u_xlat16_32 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_32) * u_xlat16_5.xyz;
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
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_6.x = (-u_xlat29) + 1.0;
    u_xlat16_9 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_9 = u_xlat16_6.x * u_xlat16_9;
    u_xlat16_9 = u_xlat16_6.x * u_xlat16_9;
    u_xlat16_6.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_15 = (-u_xlat16_6.x) + 1.0;
    u_xlat16_15 = u_xlat16_3.y + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_12.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_12.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_12.xyz;
    u_xlat16_6.xzw = u_xlat16_6.xxx * u_xlat16_2.xyz;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_15) + (-u_xlat16_7.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xzw;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = vec3(u_xlat16_32) * u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_8.xyz * u_xlat16_6.xzw + u_xlat16_5.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_32 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_32) * _LightColor0.xyz;
    u_xlat16_6.xyz = vec3(u_xlat27) * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_5.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
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
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
mediump float u_xlat16_42;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat13.xyz = u_xlat12.xyz * vec3(u_xlat1);
    u_xlat12.xyz = u_xlat12.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
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
    u_xlat16_4.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat0.x = (-u_xlat16_4.y) + 1.0;
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
    u_xlat16_41 = u_xlat16_4.z + -1.0;
    u_xlat16_41 = _Occlusion * u_xlat16_41 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz;
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_6.x = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_6.x = (-u_xlat16_6.x) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xxx;
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
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_12.xyz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz * u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_42 = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_9.xyz = vec3(u_xlat16_42) * u_xlat16_8.xyz;
    u_xlat16_42 = (-u_xlat16_42) + 1.0;
    u_xlat16_42 = u_xlat16_4.y + u_xlat16_42;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_42 = min(max(u_xlat16_42, 0.0), 1.0);
#else
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_42);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_9.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_42 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_42 = min(max(u_xlat16_42, 0.0), 1.0);
#else
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
#endif
    u_xlat16_11.xyz = vec3(u_xlat16_42) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_11.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_11.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_11.xyz = vec3(u_xlat16_41) * u_xlat16_11.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_11.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat1) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_9.xyz;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
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
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
mediump float u_xlat16_42;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat13.xyz = u_xlat12.xyz * vec3(u_xlat1);
    u_xlat12.xyz = u_xlat12.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
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
    u_xlat16_4.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat0.x = (-u_xlat16_4.y) + 1.0;
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
    u_xlat16_41 = u_xlat16_4.z + -1.0;
    u_xlat16_41 = _Occlusion * u_xlat16_41 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz;
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_6.x = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_6.x = (-u_xlat16_6.x) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xxx;
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
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_12.xyz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz * u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_42 = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_9.xyz = vec3(u_xlat16_42) * u_xlat16_8.xyz;
    u_xlat16_42 = (-u_xlat16_42) + 1.0;
    u_xlat16_42 = u_xlat16_4.y + u_xlat16_42;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_42 = min(max(u_xlat16_42, 0.0), 1.0);
#else
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_42);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_9.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_42 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_42 = min(max(u_xlat16_42, 0.0), 1.0);
#else
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
#endif
    u_xlat16_11.xyz = vec3(u_xlat16_42) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_11.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_11.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_11.xyz = vec3(u_xlat16_41) * u_xlat16_11.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_11.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat1) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_9.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
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
float u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat25;
mediump float u_xlat16_33;
mediump float u_xlat16_35;
float u_xlat36;
mediump float u_xlat16_36;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_33 = u_xlat16_3.z + -1.0;
    u_xlat16_33 = _Occlusion * u_xlat16_33 + 1.0;
    u_xlat16_0.xyz = vec3(u_xlat16_33) * u_xlat16_0.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
    u_xlat16_2.x = dot((-u_xlat4.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat4.xyz);
    u_xlat16_1 = texture(_HeuristicReflection, u_xlat16_2.xyz);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = vec3(u_xlat16_33) * u_xlat16_2.xyz;
    u_xlat25 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat5.xyz = vec3(u_xlat25) * vs_TEXCOORD1.xyz;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat36 = u_xlat25;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat25 = u_xlat25 + u_xlat25;
    u_xlat4.xyz = u_xlat5.xyz * (-vec3(u_xlat25)) + u_xlat4.xyz;
    u_xlat25 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_33 = (-u_xlat36) + 1.0;
    u_xlat16_36 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_36 = u_xlat16_33 * u_xlat16_36;
    u_xlat16_36 = u_xlat16_33 * u_xlat16_36;
    u_xlat16_33 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_35 = (-u_xlat16_33) + 1.0;
    u_xlat16_35 = u_xlat16_35 + u_xlat16_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_33) * u_xlat16_5.xyz;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat4.z = (-u_xlat16_3.y) + 1.0;
    u_xlat3 = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat3 = u_xlat3 * 16.0;
    u_xlat16_9.xyz = vec3(u_xlat3) * u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_10.xyz = vec3(u_xlat16_35) + (-u_xlat16_7.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_36) * u_xlat16_10.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_33 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_33) * _LightColor0.xyz;
    u_xlat16_2.xyz = vec3(u_xlat25) * u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_9.xyz * u_xlat16_2.xyz + u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
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
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat12;
vec3 u_xlat13;
mediump float u_xlat16_13;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_27 = u_xlat16_3.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_29 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz;
    u_xlat16_29 = (-u_xlat16_29) + 1.0;
    u_xlat16_29 = u_xlat16_29 + u_xlat16_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.y) + 1.0;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat16_29);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat4.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat4.xxx;
    u_xlat4.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat13.xyz;
    u_xlat31 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat31 = max(u_xlat31, 0.319999993);
    u_xlat16_5.x = u_xlat16_3.x * u_xlat16_3.x + 1.5;
    u_xlat31 = u_xlat31 * u_xlat16_5.x;
    u_xlat5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_13 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_29 = u_xlat16_3.x * u_xlat16_13;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat16_3.x = u_xlat16_13 * u_xlat16_13 + -1.0;
    u_xlat3.x = u_xlat4.x * u_xlat16_3.x + 1.00001001;
    u_xlat3.x = u_xlat3.x * u_xlat31;
    u_xlat3.x = u_xlat16_13 / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + -9.99999975e-05;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = min(u_xlat3.x, 100.0);
    u_xlat4.xyz = u_xlat3.xxx * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_7.x = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = u_xlat16_7.xxx * _LightColor0.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_7.xyz;
    u_xlat3.x = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat31 = dot(u_xlat5.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_7.x = (-u_xlat31) + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_2.xyz = u_xlat16_7.xxx * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat3.xxx + u_xlat16_0.xyz;
    u_xlat16_0.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_0.xxx) + (-u_xlat12.xyz);
    u_xlat16_1 = texture(_HeuristicReflection, u_xlat16_0.xyz);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_29);
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
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
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat12;
vec3 u_xlat13;
mediump float u_xlat16_13;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_27 = u_xlat16_3.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_29 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz;
    u_xlat16_29 = (-u_xlat16_29) + 1.0;
    u_xlat16_29 = u_xlat16_29 + u_xlat16_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.y) + 1.0;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat16_29);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat4.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat4.xxx;
    u_xlat4.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat13.xyz;
    u_xlat31 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat31 = max(u_xlat31, 0.319999993);
    u_xlat16_5.x = u_xlat16_3.x * u_xlat16_3.x + 1.5;
    u_xlat31 = u_xlat31 * u_xlat16_5.x;
    u_xlat5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_13 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_29 = u_xlat16_3.x * u_xlat16_13;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat16_3.x = u_xlat16_13 * u_xlat16_13 + -1.0;
    u_xlat3.x = u_xlat4.x * u_xlat16_3.x + 1.00001001;
    u_xlat3.x = u_xlat3.x * u_xlat31;
    u_xlat3.x = u_xlat16_13 / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + -9.99999975e-05;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = min(u_xlat3.x, 100.0);
    u_xlat4.xyz = u_xlat3.xxx * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_7.x = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = u_xlat16_7.xxx * _LightColor0.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_7.xyz;
    u_xlat3.x = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat31 = dot(u_xlat5.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_7.x = (-u_xlat31) + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_2.xyz = u_xlat16_7.xxx * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat3.xxx + u_xlat16_0.xyz;
    u_xlat16_0.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_0.xxx) + (-u_xlat12.xyz);
    u_xlat16_1 = texture(_HeuristicReflection, u_xlat16_0.xyz);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_29);
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
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
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
mediump vec3 u_xlat16_13;
mediump float u_xlat16_16;
float u_xlat30;
bool u_xlatb30;
float u_xlat32;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat30 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat30<9.99999975e-06);
#else
    u_xlatb30 = u_xlat30<9.99999975e-06;
#endif
    u_xlat30 = (u_xlatb30) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat2.z = u_xlat30 * u_xlat16_1.x;
    u_xlat3.x = u_xlat30 * u_xlat16_1.z;
    u_xlat2.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30) + u_xlat16_1.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat4.z = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb30 = u_xlat4.z<0.00499999989;
#endif
    u_xlat32 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb30) ? 0.0 : u_xlat32;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_35 = u_xlat16_3.z + -1.0;
    u_xlat16_35 = _Occlusion * u_xlat16_35 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_35) * u_xlat16_5.xyz;
    u_xlat30 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * vs_TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat32 = u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat30)) + u_xlat0.xyz;
    u_xlat30 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_6.x = (-u_xlat32) + 1.0;
    u_xlat16_10 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_10 = u_xlat16_6.x * u_xlat16_10;
    u_xlat16_10 = u_xlat16_6.x * u_xlat16_10;
    u_xlat16_6.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_16 = (-u_xlat16_6.x) + 1.0;
    u_xlat16_16 = u_xlat16_3.y + u_xlat16_16;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_13.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_13.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_13.xyz;
    u_xlat16_6.xzw = u_xlat16_6.xxx * u_xlat16_2.xyz;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_16) + (-u_xlat16_7.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_10) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xzw;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat16_16 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_16 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_16);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_8.xyz = unity_SHC.xyz * vec3(u_xlat16_16) + u_xlat16_8.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_8.xyz = unity_Lightmap_HDR.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_8.xyz * u_xlat16_6.xzw + u_xlat16_5.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat16_6.xyz = vec3(u_xlat30) * u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_5.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
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
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat22;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_27 = u_xlat16_3.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_29 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz;
    u_xlat16_29 = (-u_xlat16_29) + 1.0;
    u_xlat16_29 = u_xlat16_29 + u_xlat16_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat16_3.y) + 1.0;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat16_29);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat4.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat4.xxx;
    u_xlat4.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat13.xyz;
    u_xlat31 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat31 = max(u_xlat31, 0.319999993);
    u_xlat5.x = u_xlat3.x * u_xlat3.x + 1.5;
    u_xlat31 = u_xlat31 * u_xlat5.x;
    u_xlat5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat13.x = u_xlat3.x * u_xlat3.x;
    u_xlat22 = u_xlat13.x * u_xlat13.x + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat22 + 1.00001001;
    u_xlat4.x = u_xlat4.x * u_xlat31;
    u_xlat4.x = u_xlat13.x / u_xlat4.x;
    u_xlat16_29 = u_xlat3.x * u_xlat13.x;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_7.x = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = u_xlat16_7.xxx * _LightColor0.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_7.xyz;
    u_xlat31 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = (-u_xlat5.x) + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_2.xyz = u_xlat16_7.xxx * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat3.x<0.00499999989);
#else
    u_xlatb31 = u_xlat3.x<0.00499999989;
#endif
    u_xlat3.x = u_xlat3.x * 8.29800034;
    u_xlat16_0.x = (u_xlatb31) ? 0.0 : u_xlat3.x;
    u_xlat16_9 = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_9 = u_xlat16_9 + u_xlat16_9;
    u_xlat16_7.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_9)) + (-u_xlat12.xyz);
    u_xlat3.x = dot(u_xlat16_7.zxy, (-u_xlat16_7.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<9.99999975e-06);
#else
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
#endif
    u_xlat3.x = (u_xlatb3) ? u_xlat16_7.z : (-u_xlat16_7.z);
    u_xlat5.z = u_xlat3.x * u_xlat16_7.x;
    u_xlat3.x = u_xlat3.x * u_xlat16_7.z;
    u_xlat5.xy = (-u_xlat16_7.xy) * u_xlat16_7.yz;
    u_xlat3.yz = (-u_xlat16_7.xy) * u_xlat16_7.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat5.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_29);
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
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
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat22;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_27 = u_xlat16_3.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_29 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz;
    u_xlat16_29 = (-u_xlat16_29) + 1.0;
    u_xlat16_29 = u_xlat16_29 + u_xlat16_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat16_3.y) + 1.0;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat16_29);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat4.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat4.xxx;
    u_xlat4.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat13.xyz;
    u_xlat31 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat31 = max(u_xlat31, 0.319999993);
    u_xlat5.x = u_xlat3.x * u_xlat3.x + 1.5;
    u_xlat31 = u_xlat31 * u_xlat5.x;
    u_xlat5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat13.x = u_xlat3.x * u_xlat3.x;
    u_xlat22 = u_xlat13.x * u_xlat13.x + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat22 + 1.00001001;
    u_xlat4.x = u_xlat4.x * u_xlat31;
    u_xlat4.x = u_xlat13.x / u_xlat4.x;
    u_xlat16_29 = u_xlat3.x * u_xlat13.x;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_7.x = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = u_xlat16_7.xxx * _LightColor0.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_7.xyz;
    u_xlat31 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = (-u_xlat5.x) + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_2.xyz = u_xlat16_7.xxx * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat3.x<0.00499999989);
#else
    u_xlatb31 = u_xlat3.x<0.00499999989;
#endif
    u_xlat3.x = u_xlat3.x * 8.29800034;
    u_xlat16_0.x = (u_xlatb31) ? 0.0 : u_xlat3.x;
    u_xlat16_9 = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_9 = u_xlat16_9 + u_xlat16_9;
    u_xlat16_7.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_9)) + (-u_xlat12.xyz);
    u_xlat3.x = dot(u_xlat16_7.zxy, (-u_xlat16_7.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<9.99999975e-06);
#else
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
#endif
    u_xlat3.x = (u_xlatb3) ? u_xlat16_7.z : (-u_xlat16_7.z);
    u_xlat5.z = u_xlat3.x * u_xlat16_7.x;
    u_xlat3.x = u_xlat3.x * u_xlat16_7.z;
    u_xlat5.xy = (-u_xlat16_7.xy) * u_xlat16_7.yz;
    u_xlat3.yz = (-u_xlat16_7.xy) * u_xlat16_7.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat5.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_29);
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat23;
float u_xlat30;
mediump float u_xlat16_32;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat16_1 = texture(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_32 = u_xlat16_3.z + -1.0;
    u_xlat16_32 = _Occlusion * u_xlat16_32 + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_32) * u_xlat16_2.xyz;
    u_xlat30 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat4.xyz = vec3(u_xlat30) * vs_TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat23 = u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = u_xlat4.xyz * (-vec3(u_xlat30)) + u_xlat0.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat30) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_32 = (-u_xlat23) + 1.0;
    u_xlat16_10 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_10 = u_xlat16_32 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_32 * u_xlat16_10;
    u_xlat16_32 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_35 = (-u_xlat16_32) + 1.0;
    u_xlat16_35 = u_xlat16_3.y + u_xlat16_35;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.z = (-u_xlat16_3.y) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat16_8.xyz = u_xlat16_4.xyz * vec3(u_xlat16_32) + u_xlat16_8.xyz;
    u_xlat16_9.xyz = vec3(u_xlat16_35) + (-u_xlat16_7.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_10) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat16_8.xyz * u_xlat16_5.xyz + u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_14;
float u_xlat16;
float u_xlat20;
float u_xlat24;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
mediump float u_xlat16_27;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat1.xyz);
    u_xlat16_2 = texture(_HeuristicReflection, u_xlat16_2.xyz);
    u_xlat16_3.x = u_xlat16_2.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat16_3.xxx;
    u_xlat16_4.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_27 = u_xlat16_4.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_3.xyz = vec3(u_xlat16_27) * u_xlat16_3.xyz;
    u_xlat16_24 = (-u_xlat16_4.y) + 1.0;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_27 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24 + 1.5;
    u_xlat16_27 = (-u_xlat16_27) * 0.280000001 + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_27);
    u_xlat20 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat5.xyz = vec3(u_xlat20) * vs_TEXCOORD1.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_27 = (-u_xlat1.x) + 1.0;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_6 = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_14.x = (-u_xlat16_6) + 1.0;
    u_xlat16_14.x = u_xlat16_4.y + u_xlat16_14.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14.x = min(max(u_xlat16_14.x, 0.0), 1.0);
#else
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_12.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat16_12.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_12.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_14.xyz = u_xlat16_14.xxx + (-u_xlat16_7.xyz);
    u_xlat16_14.xyz = vec3(u_xlat16_27) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_14.xyz;
    u_xlat4 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = max(u_xlat4, 0.00100000005);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat4);
    u_xlat4 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16 = max(u_xlat4, 0.319999993);
    u_xlat16 = u_xlat16_24 * u_xlat16;
    u_xlat16_24 = u_xlat16_25 * u_xlat16_25 + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_24 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat16;
    u_xlat0.x = u_xlat16_25 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xzw = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xzw = u_xlat16_1.xyz * vec3(u_xlat16_6) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat8) + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_14;
float u_xlat16;
float u_xlat20;
float u_xlat24;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
mediump float u_xlat16_27;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat1.xyz);
    u_xlat16_2 = texture(_HeuristicReflection, u_xlat16_2.xyz);
    u_xlat16_3.x = u_xlat16_2.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat16_3.xxx;
    u_xlat16_4.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_27 = u_xlat16_4.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_3.xyz = vec3(u_xlat16_27) * u_xlat16_3.xyz;
    u_xlat16_24 = (-u_xlat16_4.y) + 1.0;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_27 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24 + 1.5;
    u_xlat16_27 = (-u_xlat16_27) * 0.280000001 + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_27);
    u_xlat20 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat5.xyz = vec3(u_xlat20) * vs_TEXCOORD1.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_27 = (-u_xlat1.x) + 1.0;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_6 = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_14.x = (-u_xlat16_6) + 1.0;
    u_xlat16_14.x = u_xlat16_4.y + u_xlat16_14.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14.x = min(max(u_xlat16_14.x, 0.0), 1.0);
#else
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_12.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat16_12.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_12.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_14.xyz = u_xlat16_14.xxx + (-u_xlat16_7.xyz);
    u_xlat16_14.xyz = vec3(u_xlat16_27) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_14.xyz;
    u_xlat4 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = max(u_xlat4, 0.00100000005);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat4);
    u_xlat4 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16 = max(u_xlat4, 0.319999993);
    u_xlat16 = u_xlat16_24 * u_xlat16;
    u_xlat16_24 = u_xlat16_25 * u_xlat16_25 + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_24 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat16;
    u_xlat0.x = u_xlat16_25 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xzw = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xzw = u_xlat16_1.xyz * vec3(u_xlat16_6) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat8) + u_xlat16_3.xyz;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
mediump vec3 u_xlat16_12;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
mediump float u_xlat16_32;
mediump float u_xlat16_33;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat4.z = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb27 = u_xlat4.z<0.00499999989;
#endif
    u_xlat29 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? 0.0 : u_xlat29;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_32 = u_xlat16_3.z + -1.0;
    u_xlat16_32 = _Occlusion * u_xlat16_32 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_32) * u_xlat16_5.xyz;
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
    u_xlat16_6.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_32 = (-u_xlat29) + 1.0;
    u_xlat16_9 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_9 = u_xlat16_32 * u_xlat16_9;
    u_xlat16_9 = u_xlat16_32 * u_xlat16_9;
    u_xlat16_32 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_33 = (-u_xlat16_32) + 1.0;
    u_xlat16_33 = u_xlat16_3.y + u_xlat16_33;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_12.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_12.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_12.xyz;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_33) + (-u_xlat16_7.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * vec3(u_xlat16_32) + u_xlat16_7.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_0.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4;
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
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_12;
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
    u_xlat16_4.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat0.x = (-u_xlat16_4.y) + 1.0;
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
    u_xlat16_29 = u_xlat16_4.z + -1.0;
    u_xlat16_29 = _Occlusion * u_xlat16_29 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_29) * u_xlat16_5.xyz;
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
    u_xlat16_6 = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_14.x = (-u_xlat16_6) + 1.0;
    u_xlat16_14.x = u_xlat16_4.y + u_xlat16_14.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14.x = min(max(u_xlat16_14.x, 0.0), 1.0);
#else
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_12.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_9.xyz * u_xlat16_12.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_12.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
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
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat8.x = u_xlat8.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
float u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_12;
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
    u_xlat16_4.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat0.x = (-u_xlat16_4.y) + 1.0;
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
    u_xlat16_29 = u_xlat16_4.z + -1.0;
    u_xlat16_29 = _Occlusion * u_xlat16_29 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_29) * u_xlat16_5.xyz;
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
    u_xlat16_6 = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_14.x = (-u_xlat16_6) + 1.0;
    u_xlat16_14.x = u_xlat16_4.y + u_xlat16_14.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14.x = min(max(u_xlat16_14.x, 0.0), 1.0);
#else
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0, 1.0);
#endif
    u_xlat16_9.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_12.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_9.xyz * u_xlat16_12.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_12.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
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
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat8.x = u_xlat8.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat8.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
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
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_17;
float u_xlat25;
float u_xlat33;
mediump float u_xlat16_35;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat16_1 = texture(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_35 = u_xlat16_3.z + -1.0;
    u_xlat16_35 = _Occlusion * u_xlat16_35 + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat25 = u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = u_xlat4.xyz * (-vec3(u_xlat33)) + u_xlat0.xyz;
    u_xlat33 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat33) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = (-u_xlat25) + 1.0;
    u_xlat16_11 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_11 = u_xlat16_38 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_38 * u_xlat16_11;
    u_xlat16_38 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.x = (-u_xlat16_38) + 1.0;
    u_xlat16_6.x = u_xlat16_3.y + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_17.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_4.xyz;
    u_xlat16_17.xyz = u_xlat16_3.xxx * u_xlat16_17.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.z = (-u_xlat16_3.y) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_9.xyz = u_xlat0.xxx * u_xlat16_17.xyz + u_xlat16_8.xyz;
    u_xlat16_10.xyz = (-u_xlat16_17.xyz) + u_xlat16_6.xxx;
    u_xlat16_6.xyz = vec3(u_xlat16_11) * u_xlat16_10.xyz + u_xlat16_17.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_6.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_6.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_6.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_6.xyz = u_xlat16_6.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_9.xyz * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD4;
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
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_17;
mediump vec3 u_xlat16_18;
mediump float u_xlat16_21;
float u_xlat30;
float u_xlat31;
mediump float u_xlat16_31;
float u_xlat32;
mediump float u_xlat16_32;
mediump float u_xlat16_37;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat30 = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = max(u_xlat30, 0.319999993);
    u_xlat16_2.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_31 = (-u_xlat16_2.y) + 1.0;
    u_xlat16_32 = u_xlat16_31 * u_xlat16_31 + 1.5;
    u_xlat30 = u_xlat30 * u_xlat16_32;
    u_xlat32 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat3.xyz = vec3(u_xlat32) * vs_TEXCOORD1.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_11 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_4 = u_xlat16_31 * u_xlat16_11;
    u_xlat16_4 = (-u_xlat16_4) * 0.280000001 + 1.0;
    u_xlat16_21 = u_xlat16_11 * u_xlat16_11 + -1.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_21 + 1.00001001;
    u_xlat30 = u_xlat30 * u_xlat1.x;
    u_xlat30 = u_xlat16_11 / u_xlat30;
    u_xlat30 = u_xlat30 + -9.99999975e-05;
    u_xlat30 = max(u_xlat30, 0.0);
    u_xlat30 = min(u_xlat30, 100.0);
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz;
    u_xlat16_14.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_14.xyz = u_xlat16_2.xxx * u_xlat16_14.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_17.xyz = u_xlat16_6.xyz * u_xlat16_7.xxx;
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_7.x = u_xlat16_2.y + u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat16_2.z + -1.0;
    u_xlat16_8 = _Occlusion * u_xlat16_8 + 1.0;
    u_xlat16_18.xyz = (-u_xlat16_14.xyz) + u_xlat16_7.xxx;
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat16_14.xyz + u_xlat16_17.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_2.xyz;
    u_xlat16_7.xyz = u_xlat16_17.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat31 = dot(u_xlat3.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_37 = (-u_xlat31) + 1.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_14.xyz = vec3(u_xlat16_37) * u_xlat16_18.xyz + u_xlat16_14.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat16_7.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_7.xxx) + (-u_xlat0.xyz);
    u_xlat16_0 = texture(_HeuristicReflection, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_0.w + -1.0;
    u_xlat16_7.x = unity_SpecCube0_HDR.w * u_xlat16_7.x + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_4) * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * u_xlat16_14.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
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
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_17;
mediump vec3 u_xlat16_18;
mediump float u_xlat16_21;
float u_xlat30;
float u_xlat31;
mediump float u_xlat16_31;
float u_xlat32;
mediump float u_xlat16_32;
mediump float u_xlat16_37;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
    u_xlat30 = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = max(u_xlat30, 0.319999993);
    u_xlat16_2.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_31 = (-u_xlat16_2.y) + 1.0;
    u_xlat16_32 = u_xlat16_31 * u_xlat16_31 + 1.5;
    u_xlat30 = u_xlat30 * u_xlat16_32;
    u_xlat32 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat3.xyz = vec3(u_xlat32) * vs_TEXCOORD1.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_11 = u_xlat16_31 * u_xlat16_31;
    u_xlat16_4 = u_xlat16_31 * u_xlat16_11;
    u_xlat16_4 = (-u_xlat16_4) * 0.280000001 + 1.0;
    u_xlat16_21 = u_xlat16_11 * u_xlat16_11 + -1.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_21 + 1.00001001;
    u_xlat30 = u_xlat30 * u_xlat1.x;
    u_xlat30 = u_xlat16_11 / u_xlat30;
    u_xlat30 = u_xlat30 + -9.99999975e-05;
    u_xlat30 = max(u_xlat30, 0.0);
    u_xlat30 = min(u_xlat30, 100.0);
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz;
    u_xlat16_14.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_14.xyz = u_xlat16_2.xxx * u_xlat16_14.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_17.xyz = u_xlat16_6.xyz * u_xlat16_7.xxx;
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_7.x = u_xlat16_2.y + u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat16_2.z + -1.0;
    u_xlat16_8 = _Occlusion * u_xlat16_8 + 1.0;
    u_xlat16_18.xyz = (-u_xlat16_14.xyz) + u_xlat16_7.xxx;
    u_xlat1.xyz = vec3(u_xlat30) * u_xlat16_14.xyz + u_xlat16_17.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat2.xyz = vs_TEXCOORD1.xyz;
    u_xlat2.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat2);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat2);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat2);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_2.xyz;
    u_xlat16_7.xyz = u_xlat16_17.xyz * u_xlat16_9.xyz;
    u_xlat30 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat31 = dot(u_xlat3.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_37 = (-u_xlat31) + 1.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_14.xyz = vec3(u_xlat16_37) * u_xlat16_18.xyz + u_xlat16_14.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat16_7.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_7.xxx) + (-u_xlat0.xyz);
    u_xlat16_0 = texture(_HeuristicReflection, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_0.w + -1.0;
    u_xlat16_7.x = unity_SpecCube0_HDR.w * u_xlat16_7.x + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_4) * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * u_xlat16_14.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
mediump vec3 u_xlat16_13;
mediump vec3 u_xlat16_17;
float u_xlat30;
bool u_xlatb30;
float u_xlat32;
mediump float u_xlat16_35;
mediump float u_xlat16_36;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat30 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat30<9.99999975e-06);
#else
    u_xlatb30 = u_xlat30<9.99999975e-06;
#endif
    u_xlat30 = (u_xlatb30) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat2.z = u_xlat30 * u_xlat16_1.x;
    u_xlat3.x = u_xlat30 * u_xlat16_1.z;
    u_xlat2.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30) + u_xlat16_1.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat4.z = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb30 = u_xlat4.z<0.00499999989;
#endif
    u_xlat32 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb30) ? 0.0 : u_xlat32;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_35 = u_xlat16_3.z + -1.0;
    u_xlat16_35 = _Occlusion * u_xlat16_35 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_35) * u_xlat16_5.xyz;
    u_xlat30 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * vs_TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat32 = u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat30)) + u_xlat0.xyz;
    u_xlat30 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
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
    u_xlat16_36 = (-u_xlat32) + 1.0;
    u_xlat16_10 = u_xlat16_36 * u_xlat16_36;
    u_xlat16_10 = u_xlat16_36 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_36 * u_xlat16_10;
    u_xlat16_36 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.x = (-u_xlat16_36) + 1.0;
    u_xlat16_7.x = u_xlat16_3.y + u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_13.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_17.xyz = u_xlat16_2.xyz * u_xlat16_13.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_13.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_36) * u_xlat16_2.xyz;
    u_xlat16_17.xyz = u_xlat16_3.xxx * u_xlat16_17.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_9.xyz = (-u_xlat16_17.xyz) + u_xlat16_7.xxx;
    u_xlat16_9.xyz = vec3(u_xlat16_10) * u_xlat16_9.xyz + u_xlat16_17.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_17.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_9.xyz = vec3(u_xlat16_35) * u_xlat16_0.xyz;
    u_xlat16_5.xyz = u_xlat16_9.xyz * u_xlat16_8.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_0.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
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
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_17;
float u_xlat18;
float u_xlat24;
float u_xlat26;
bool u_xlatb26;
mediump float u_xlat16_29;
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
    u_xlat16_2.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.x = u_xlat16_2.z + -1.0;
    u_xlat16_1.x = _Occlusion * u_xlat16_1.x + 1.0;
    u_xlat16_9.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_29 = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_4.xyz * vec3(u_xlat16_29);
    u_xlat16_29 = (-u_xlat16_29) + 1.0;
    u_xlat16_29 = u_xlat16_2.y + u_xlat16_29;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat16_2.y) + 1.0;
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + vec3(u_xlat16_29);
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_6.xyz;
    u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat10.xyz = u_xlat8.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat2.xxx;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat26 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat26 = max(u_xlat26, 0.319999993);
    u_xlat3.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat26 = u_xlat26 * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat10.x = u_xlat0.x * u_xlat0.x;
    u_xlat18 = u_xlat10.x * u_xlat10.x + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat18 + 1.00001001;
    u_xlat2.x = u_xlat2.x * u_xlat26;
    u_xlat2.x = u_xlat10.x / u_xlat2.x;
    u_xlat16_29 = u_xlat0.x * u_xlat10.x;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _LightColor0.xyz;
    u_xlat26 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat3.x) + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.xyz = u_xlat16_6.xxx * u_xlat16_7.xyz + u_xlat16_5.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat26) + u_xlat16_9.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb26 = u_xlat0.x<0.00499999989;
#endif
    u_xlat0.x = u_xlat0.x * 8.29800034;
    u_xlat16_9.x = (u_xlatb26) ? 0.0 : u_xlat0.x;
    u_xlat16_17 = dot((-u_xlat8.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_6.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_17)) + (-u_xlat8.xyz);
    u_xlat0.x = dot(u_xlat16_6.zxy, (-u_xlat16_6.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<9.99999975e-06);
#else
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
#endif
    u_xlat0.x = (u_xlatb0) ? u_xlat16_6.z : (-u_xlat16_6.z);
    u_xlat3.z = u_xlat0.x * u_xlat16_6.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_6.z;
    u_xlat3.xy = (-u_xlat16_6.xy) * u_xlat16_6.yz;
    u_xlat0.yz = (-u_xlat16_6.xy) * u_xlat16_6.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_6.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_9.x);
    u_xlat16_9.x = u_xlat16_0.w + -1.0;
    u_xlat16_9.x = unity_SpecCube0_HDR.w * u_xlat16_9.x + 1.0;
    u_xlat16_9.x = u_xlat16_9.x * unity_SpecCube0_HDR.x;
    u_xlat16_9.xyz = u_xlat16_0.xyz * u_xlat16_9.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_9.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_29);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD4;
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
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump vec3 u_xlat16_9;
vec3 u_xlat10;
mediump float u_xlat16_17;
float u_xlat18;
float u_xlat24;
float u_xlat26;
bool u_xlatb26;
mediump float u_xlat16_29;
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
    u_xlat16_2.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.x = u_xlat16_2.z + -1.0;
    u_xlat16_1.x = _Occlusion * u_xlat16_1.x + 1.0;
    u_xlat16_9.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_0.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_2.xxx * u_xlat16_5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_29 = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.xyz = u_xlat16_4.xyz * vec3(u_xlat16_29);
    u_xlat16_29 = (-u_xlat16_29) + 1.0;
    u_xlat16_29 = u_xlat16_2.y + u_xlat16_29;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat16_2.y) + 1.0;
    u_xlat16_7.xyz = (-u_xlat16_5.xyz) + vec3(u_xlat16_29);
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_6.xyz;
    u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.x = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat10.xyz = u_xlat8.xyz * u_xlat2.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat8.xyz = u_xlat8.xyz * u_xlat2.xxx;
    u_xlat2.x = dot(u_xlat10.xyz, u_xlat10.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.00100000005);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10.xyz;
    u_xlat26 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat26 = max(u_xlat26, 0.319999993);
    u_xlat3.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat26 = u_xlat26 * u_xlat3.x;
    u_xlat3.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat10.x = u_xlat0.x * u_xlat0.x;
    u_xlat18 = u_xlat10.x * u_xlat10.x + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat18 + 1.00001001;
    u_xlat2.x = u_xlat2.x * u_xlat26;
    u_xlat2.x = u_xlat10.x / u_xlat2.x;
    u_xlat16_29 = u_xlat0.x * u_xlat10.x;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat2.x = u_xlat2.x + -9.99999975e-05;
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = min(u_xlat2.x, 100.0);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_5.xyz + u_xlat16_6.xyz;
    u_xlat2.xyz = u_xlat2.xyz * _LightColor0.xyz;
    u_xlat26 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat3.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_6.x = (-u_xlat3.x) + 1.0;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_5.xyz = u_xlat16_6.xxx * u_xlat16_7.xyz + u_xlat16_5.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat26) + u_xlat16_9.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb26 = !!(u_xlat0.x<0.00499999989);
#else
    u_xlatb26 = u_xlat0.x<0.00499999989;
#endif
    u_xlat0.x = u_xlat0.x * 8.29800034;
    u_xlat16_9.x = (u_xlatb26) ? 0.0 : u_xlat0.x;
    u_xlat16_17 = dot((-u_xlat8.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_6.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_17)) + (-u_xlat8.xyz);
    u_xlat0.x = dot(u_xlat16_6.zxy, (-u_xlat16_6.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<9.99999975e-06);
#else
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
#endif
    u_xlat0.x = (u_xlatb0) ? u_xlat16_6.z : (-u_xlat16_6.z);
    u_xlat3.z = u_xlat0.x * u_xlat16_6.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_6.z;
    u_xlat3.xy = (-u_xlat16_6.xy) * u_xlat16_6.yz;
    u_xlat0.yz = (-u_xlat16_6.xy) * u_xlat16_6.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat24 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _NormalRand.w;
    u_xlat24 = fract(u_xlat24);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat16_6.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_9.x);
    u_xlat16_9.x = u_xlat16_0.w + -1.0;
    u_xlat16_9.x = unity_SpecCube0_HDR.w * u_xlat16_9.x + 1.0;
    u_xlat16_9.x = u_xlat16_9.x * unity_SpecCube0_HDR.x;
    u_xlat16_9.xyz = u_xlat16_0.xyz * u_xlat16_9.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_9.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_29);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD4;
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
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
mediump float u_xlat16_15;
float u_xlat23;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat16_1 = texture(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_32 = u_xlat16_3.z + -1.0;
    u_xlat16_32 = _Occlusion * u_xlat16_32 + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_32) * u_xlat16_2.xyz;
    u_xlat30 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat4.xyz = vec3(u_xlat30) * vs_TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat23 = u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = u_xlat4.xyz * (-vec3(u_xlat30)) + u_xlat0.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_5.x = (-u_xlat23) + 1.0;
    u_xlat16_10 = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_10 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_10 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_15 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_15 = u_xlat16_3.y + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xzw = u_xlat16_5.xxx * u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.z = (-u_xlat16_3.y) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_5.xzw;
    u_xlat16_9.xyz = vec3(u_xlat16_15) + (-u_xlat16_7.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_10) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_7.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_7.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_7.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_7.xyz = u_xlat16_7.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_7.xyz = max(u_xlat16_7.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_7.xyz = vec3(u_xlat16_32) * u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_7.xyz * u_xlat16_5.xzw + u_xlat16_2.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_32 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_32) * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat30) * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_8.xyz * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
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
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_12;
mediump float u_xlat16_22;
float u_xlat30;
mediump float u_xlat16_31;
float u_xlat32;
mediump float u_xlat16_32;
float u_xlat33;
mediump float u_xlat16_33;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat30 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = max(u_xlat30, 0.319999993);
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_32 = (-u_xlat16_3.y) + 1.0;
    u_xlat16_33 = u_xlat16_32 * u_xlat16_32 + 1.5;
    u_xlat30 = u_xlat30 * u_xlat16_33;
    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_12 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_31 = u_xlat16_32 * u_xlat16_12;
    u_xlat16_31 = (-u_xlat16_31) * 0.280000001 + 1.0;
    u_xlat16_22 = u_xlat16_12 * u_xlat16_12 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat16_22 + 1.00001001;
    u_xlat30 = u_xlat30 * u_xlat2.x;
    u_xlat30 = u_xlat16_12 / u_xlat30;
    u_xlat30 = u_xlat30 + -9.99999975e-05;
    u_xlat30 = max(u_xlat30, 0.0);
    u_xlat30 = min(u_xlat30, 100.0);
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_37 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_8.xyz = u_xlat16_6.xyz * vec3(u_xlat16_37);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = u_xlat16_3.y + u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_3.z + -1.0;
    u_xlat16_38 = _Occlusion * u_xlat16_38 + 1.0;
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_37);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = vs_TEXCOORD1.xyz;
    u_xlat3.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = vec3(u_xlat16_38) * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat32 = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat16_37 = (-u_xlat32) + 1.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_7.xyz = vec3(u_xlat16_37) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30) + u_xlat16_1.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat16_0 = texture(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_1.x = u_xlat16_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(u_xlat16_38) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_31);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
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
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_12;
mediump float u_xlat16_22;
float u_xlat30;
mediump float u_xlat16_31;
float u_xlat32;
mediump float u_xlat16_32;
float u_xlat33;
mediump float u_xlat16_33;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat30 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = max(u_xlat30, 0.319999993);
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_32 = (-u_xlat16_3.y) + 1.0;
    u_xlat16_33 = u_xlat16_32 * u_xlat16_32 + 1.5;
    u_xlat30 = u_xlat30 * u_xlat16_33;
    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_12 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_31 = u_xlat16_32 * u_xlat16_12;
    u_xlat16_31 = (-u_xlat16_31) * 0.280000001 + 1.0;
    u_xlat16_22 = u_xlat16_12 * u_xlat16_12 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat16_22 + 1.00001001;
    u_xlat30 = u_xlat30 * u_xlat2.x;
    u_xlat30 = u_xlat16_12 / u_xlat30;
    u_xlat30 = u_xlat30 + -9.99999975e-05;
    u_xlat30 = max(u_xlat30, 0.0);
    u_xlat30 = min(u_xlat30, 100.0);
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_37 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_8.xyz = u_xlat16_6.xyz * vec3(u_xlat16_37);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = u_xlat16_3.y + u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_3.z + -1.0;
    u_xlat16_38 = _Occlusion * u_xlat16_38 + 1.0;
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_37);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = vs_TEXCOORD1.xyz;
    u_xlat3.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = vec3(u_xlat16_38) * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat32 = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat16_37 = (-u_xlat32) + 1.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_7.xyz = vec3(u_xlat16_37) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30) + u_xlat16_1.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat16_0 = texture(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_1.x = u_xlat16_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(u_xlat16_38) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_31);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
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
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_15;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat4.z = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb27 = u_xlat4.z<0.00499999989;
#endif
    u_xlat29 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? 0.0 : u_xlat29;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_32 = u_xlat16_3.z + -1.0;
    u_xlat16_32 = _Occlusion * u_xlat16_32 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_32) * u_xlat16_5.xyz;
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
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_6.x = (-u_xlat29) + 1.0;
    u_xlat16_9 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_9 = u_xlat16_6.x * u_xlat16_9;
    u_xlat16_9 = u_xlat16_6.x * u_xlat16_9;
    u_xlat16_6.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_15 = (-u_xlat16_6.x) + 1.0;
    u_xlat16_15 = u_xlat16_3.y + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_12.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_12.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_12.xyz;
    u_xlat16_6.xzw = u_xlat16_6.xxx * u_xlat16_2.xyz;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_15) + (-u_xlat16_7.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xzw;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_8.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_8.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_8.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_8.xyz = u_xlat16_8.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_8.xyz = vec3(u_xlat16_32) * u_xlat16_0.xyz;
    u_xlat16_5.xyz = u_xlat16_8.xyz * u_xlat16_6.xzw + u_xlat16_5.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_32 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_32) * _LightColor0.xyz;
    u_xlat16_6.xyz = vec3(u_xlat27) * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_0.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4;
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
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
float u_xlat12;
float u_xlat22;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
float u_xlat32;
float u_xlat33;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat30 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = max(u_xlat30, 0.319999993);
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat32 = (-u_xlat16_3.y) + 1.0;
    u_xlat33 = u_xlat32 * u_xlat32 + 1.5;
    u_xlat30 = u_xlat30 * u_xlat33;
    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat12 = u_xlat32 * u_xlat32;
    u_xlat22 = u_xlat12 * u_xlat12 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat22 + 1.00001001;
    u_xlat30 = u_xlat30 * u_xlat2.x;
    u_xlat30 = u_xlat12 / u_xlat30;
    u_xlat16_31 = u_xlat32 * u_xlat12;
    u_xlat16_31 = (-u_xlat16_31) * 0.280000001 + 1.0;
    u_xlat30 = u_xlat30 + -9.99999975e-05;
    u_xlat30 = max(u_xlat30, 0.0);
    u_xlat30 = min(u_xlat30, 100.0);
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_37 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_8.xyz = u_xlat16_6.xyz * vec3(u_xlat16_37);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = u_xlat16_3.y + u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_3.z + -1.0;
    u_xlat16_38 = _Occlusion * u_xlat16_38 + 1.0;
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_37);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = vs_TEXCOORD1.xyz;
    u_xlat3.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = vec3(u_xlat16_38) * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_37 = (-u_xlat3.x) + 1.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_7.xyz = vec3(u_xlat16_37) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30) + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat32<0.00499999989);
#else
    u_xlatb30 = u_xlat32<0.00499999989;
#endif
    u_xlat32 = u_xlat32 * 8.29800034;
    u_xlat16_1.x = (u_xlatb30) ? 0.0 : u_xlat32;
    u_xlat16_11 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_11 = u_xlat16_11 + u_xlat16_11;
    u_xlat16_8.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_11)) + (-u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat16_8.zxy, (-u_xlat16_8.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<9.99999975e-06);
#else
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
#endif
    u_xlat0.x = (u_xlatb0) ? u_xlat16_8.z : (-u_xlat16_8.z);
    u_xlat3.z = u_xlat0.x * u_xlat16_8.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_8.z;
    u_xlat3.xy = (-u_xlat16_8.xy) * u_xlat16_8.yz;
    u_xlat0.yz = (-u_xlat16_8.xy) * u_xlat16_8.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_8.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(u_xlat16_38) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_31);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_OcclusionMaskSelector;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
float u_xlat12;
float u_xlat22;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_31;
float u_xlat32;
float u_xlat33;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat30 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = max(u_xlat30, 0.319999993);
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat32 = (-u_xlat16_3.y) + 1.0;
    u_xlat33 = u_xlat32 * u_xlat32 + 1.5;
    u_xlat30 = u_xlat30 * u_xlat33;
    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat12 = u_xlat32 * u_xlat32;
    u_xlat22 = u_xlat12 * u_xlat12 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat22 + 1.00001001;
    u_xlat30 = u_xlat30 * u_xlat2.x;
    u_xlat30 = u_xlat12 / u_xlat30;
    u_xlat16_31 = u_xlat32 * u_xlat12;
    u_xlat16_31 = (-u_xlat16_31) * 0.280000001 + 1.0;
    u_xlat30 = u_xlat30 + -9.99999975e-05;
    u_xlat30 = max(u_xlat30, 0.0);
    u_xlat30 = min(u_xlat30, 100.0);
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_37 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_8.xyz = u_xlat16_6.xyz * vec3(u_xlat16_37);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = u_xlat16_3.y + u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_3.z + -1.0;
    u_xlat16_38 = _Occlusion * u_xlat16_38 + 1.0;
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_37);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = vs_TEXCOORD1.xyz;
    u_xlat3.w = 1.0;
    u_xlat16_1.x = dot(unity_SHAr, u_xlat3);
    u_xlat16_1.y = dot(unity_SHAg, u_xlat3);
    u_xlat16_1.z = dot(unity_SHAb, u_xlat3);
    u_xlat16_1.xyz = u_xlat16_1.xyz + vs_TEXCOORD3.xyz;
    u_xlat16_1.xyz = max(u_xlat16_1.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = log2(u_xlat16_1.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_1.xyz = vec3(u_xlat16_38) * u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_8.xyz * u_xlat16_1.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat3.x = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_37 = (-u_xlat3.x) + 1.0;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_37 = u_xlat16_37 * u_xlat16_37;
    u_xlat16_7.xyz = vec3(u_xlat16_37) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30) + u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat32<0.00499999989);
#else
    u_xlatb30 = u_xlat32<0.00499999989;
#endif
    u_xlat32 = u_xlat32 * 8.29800034;
    u_xlat16_1.x = (u_xlatb30) ? 0.0 : u_xlat32;
    u_xlat16_11 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_11 = u_xlat16_11 + u_xlat16_11;
    u_xlat16_8.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_11)) + (-u_xlat0.xyz);
    u_xlat0.x = dot(u_xlat16_8.zxy, (-u_xlat16_8.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<9.99999975e-06);
#else
    u_xlatb0 = u_xlat0.x<9.99999975e-06;
#endif
    u_xlat0.x = (u_xlatb0) ? u_xlat16_8.z : (-u_xlat16_8.z);
    u_xlat3.z = u_xlat0.x * u_xlat16_8.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_8.z;
    u_xlat3.xy = (-u_xlat16_8.xy) * u_xlat16_8.yz;
    u_xlat0.yz = (-u_xlat16_8.xy) * u_xlat16_8.xy;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat3.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat16_8.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_0 = texture(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_0.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(u_xlat16_38) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_31);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat16_7.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_17;
float u_xlat25;
float u_xlat33;
mediump float u_xlat16_35;
mediump float u_xlat16_38;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat16_1 = texture(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_35 = u_xlat16_3.z + -1.0;
    u_xlat16_35 = _Occlusion * u_xlat16_35 + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_35) * u_xlat16_2.xyz;
    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat25 = u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = u_xlat4.xyz * (-vec3(u_xlat33)) + u_xlat0.xyz;
    u_xlat33 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat33) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_38 = (-u_xlat25) + 1.0;
    u_xlat16_11 = u_xlat16_38 * u_xlat16_38;
    u_xlat16_11 = u_xlat16_38 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_38 * u_xlat16_11;
    u_xlat16_38 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_6.x = (-u_xlat16_38) + 1.0;
    u_xlat16_6.x = u_xlat16_3.y + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_17.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_7.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_38) * u_xlat16_4.xyz;
    u_xlat16_17.xyz = u_xlat16_3.xxx * u_xlat16_17.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.z = (-u_xlat16_3.y) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_9.xyz = u_xlat0.xxx * u_xlat16_17.xyz + u_xlat16_8.xyz;
    u_xlat16_10.xyz = (-u_xlat16_17.xyz) + u_xlat16_6.xxx;
    u_xlat16_6.xyz = vec3(u_xlat16_11) * u_xlat16_10.xyz + u_xlat16_17.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_6.xyz = vec3(u_xlat16_35) * u_xlat16_6.xyz;
    u_xlat16_2.xyz = u_xlat16_6.xyz * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_9.xyz * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat33 = vs_TEXCOORD4;
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump float u_xlat16_10;
mediump vec3 u_xlat16_13;
mediump vec3 u_xlat16_16;
mediump vec3 u_xlat16_17;
mediump float u_xlat16_19;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_28;
float u_xlat29;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat27 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat1.xyz;
    u_xlat27 = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 0.319999993);
    u_xlat16_2.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_28 = (-u_xlat16_2.y) + 1.0;
    u_xlat16_29 = u_xlat16_28 * u_xlat16_28 + 1.5;
    u_xlat27 = u_xlat27 * u_xlat16_29;
    u_xlat29 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat3.xyz = vec3(u_xlat29) * vs_TEXCOORD1.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_10 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_4 = u_xlat16_28 * u_xlat16_10;
    u_xlat16_4 = (-u_xlat16_4) * 0.280000001 + 1.0;
    u_xlat16_19 = u_xlat16_10 * u_xlat16_10 + -1.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_19 + 1.00001001;
    u_xlat27 = u_xlat27 * u_xlat1.x;
    u_xlat27 = u_xlat16_10 / u_xlat27;
    u_xlat27 = u_xlat27 + -9.99999975e-05;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 100.0);
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz;
    u_xlat16_13.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_13.xyz = u_xlat16_2.xxx * u_xlat16_13.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_16.xyz = u_xlat16_6.xyz * u_xlat16_7.xxx;
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_7.x = u_xlat16_2.y + u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat16_2.z + -1.0;
    u_xlat16_8 = _Occlusion * u_xlat16_8 + 1.0;
    u_xlat16_17.xyz = (-u_xlat16_13.xyz) + u_xlat16_7.xxx;
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat16_13.xyz + u_xlat16_16.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat27 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat28 = dot(u_xlat3.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat16_7.x = (-u_xlat28) + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_13.xyz = u_xlat16_7.xxx * u_xlat16_17.xyz + u_xlat16_13.xyz;
    u_xlat16_2.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_17.xyz = u_xlat16_2.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_17.xyz = vec3(u_xlat16_8) * u_xlat16_17.xyz;
    u_xlat16_7.xyz = u_xlat16_16.xyz * u_xlat16_17.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27) + u_xlat16_7.xyz;
    u_xlat16_7.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_7.xxx) + (-u_xlat0.xyz);
    u_xlat16_0 = texture(_HeuristicReflection, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_0.w + -1.0;
    u_xlat16_7.x = unity_SpecCube0_HDR.w * u_xlat16_7.x + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_4) * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * u_xlat16_13.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4;
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump float u_xlat16_10;
mediump vec3 u_xlat16_13;
mediump vec3 u_xlat16_16;
mediump vec3 u_xlat16_17;
mediump float u_xlat16_19;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_28;
float u_xlat29;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
    u_xlat27 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat1.xyz;
    u_xlat27 = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat27 = max(u_xlat27, 0.319999993);
    u_xlat16_2.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_28 = (-u_xlat16_2.y) + 1.0;
    u_xlat16_29 = u_xlat16_28 * u_xlat16_28 + 1.5;
    u_xlat27 = u_xlat27 * u_xlat16_29;
    u_xlat29 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat3.xyz = vec3(u_xlat29) * vs_TEXCOORD1.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16_10 = u_xlat16_28 * u_xlat16_28;
    u_xlat16_4 = u_xlat16_28 * u_xlat16_10;
    u_xlat16_4 = (-u_xlat16_4) * 0.280000001 + 1.0;
    u_xlat16_19 = u_xlat16_10 * u_xlat16_10 + -1.0;
    u_xlat1.x = u_xlat1.x * u_xlat16_19 + 1.00001001;
    u_xlat27 = u_xlat27 * u_xlat1.x;
    u_xlat27 = u_xlat16_10 / u_xlat27;
    u_xlat27 = u_xlat27 + -9.99999975e-05;
    u_xlat27 = max(u_xlat27, 0.0);
    u_xlat27 = min(u_xlat27, 100.0);
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz;
    u_xlat16_13.xyz = u_xlat16_1.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_13.xyz = u_xlat16_2.xxx * u_xlat16_13.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_7.x = (-u_xlat16_2.x) * 0.779083729 + 0.779083729;
    u_xlat16_16.xyz = u_xlat16_6.xyz * u_xlat16_7.xxx;
    u_xlat16_7.x = (-u_xlat16_7.x) + 1.0;
    u_xlat16_7.x = u_xlat16_2.y + u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat16_2.z + -1.0;
    u_xlat16_8 = _Occlusion * u_xlat16_8 + 1.0;
    u_xlat16_17.xyz = (-u_xlat16_13.xyz) + u_xlat16_7.xxx;
    u_xlat1.xyz = vec3(u_xlat27) * u_xlat16_13.xyz + u_xlat16_16.xyz;
    u_xlat1.xyz = u_xlat1.xyz * _LightColor0.xyz;
    u_xlat27 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat28 = dot(u_xlat3.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat16_7.x = (-u_xlat28) + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_13.xyz = u_xlat16_7.xxx * u_xlat16_17.xyz + u_xlat16_13.xyz;
    u_xlat16_2.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_17.xyz = u_xlat16_2.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_17.xyz = vec3(u_xlat16_8) * u_xlat16_17.xyz;
    u_xlat16_7.xyz = u_xlat16_16.xyz * u_xlat16_17.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat27) + u_xlat16_7.xyz;
    u_xlat16_7.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_7.xxx) + (-u_xlat0.xyz);
    u_xlat16_0 = texture(_HeuristicReflection, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_0.w + -1.0;
    u_xlat16_7.x = unity_SpecCube0_HDR.w * u_xlat16_7.x + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_8) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_4) * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * u_xlat16_13.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4;
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
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
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
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
mediump vec3 u_xlat16_13;
mediump vec3 u_xlat16_17;
float u_xlat30;
bool u_xlatb30;
float u_xlat32;
mediump float u_xlat16_35;
mediump float u_xlat16_36;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat30 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat30<9.99999975e-06);
#else
    u_xlatb30 = u_xlat30<9.99999975e-06;
#endif
    u_xlat30 = (u_xlatb30) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat2.z = u_xlat30 * u_xlat16_1.x;
    u_xlat3.x = u_xlat30 * u_xlat16_1.z;
    u_xlat2.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30) + u_xlat16_1.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat4.z = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb30 = u_xlat4.z<0.00499999989;
#endif
    u_xlat32 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb30) ? 0.0 : u_xlat32;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_35 = u_xlat16_3.z + -1.0;
    u_xlat16_35 = _Occlusion * u_xlat16_35 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_35) * u_xlat16_5.xyz;
    u_xlat30 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * vs_TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat32 = u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat30)) + u_xlat0.xyz;
    u_xlat30 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
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
    u_xlat16_36 = (-u_xlat32) + 1.0;
    u_xlat16_10 = u_xlat16_36 * u_xlat16_36;
    u_xlat16_10 = u_xlat16_36 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_36 * u_xlat16_10;
    u_xlat16_36 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.x = (-u_xlat16_36) + 1.0;
    u_xlat16_7.x = u_xlat16_3.y + u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_13.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_17.xyz = u_xlat16_2.xyz * u_xlat16_13.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_13.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_36) * u_xlat16_2.xyz;
    u_xlat16_17.xyz = u_xlat16_3.xxx * u_xlat16_17.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_9.xyz = (-u_xlat16_17.xyz) + u_xlat16_7.xxx;
    u_xlat16_9.xyz = vec3(u_xlat16_10) * u_xlat16_9.xyz + u_xlat16_17.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_17.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_9.xyz = vec3(u_xlat16_35) * u_xlat16_9.xyz;
    u_xlat16_5.xyz = u_xlat16_9.xyz * u_xlat16_8.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_0.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
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
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
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
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
mediump float u_xlat16_42;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat13.xyz = u_xlat12.xyz * vec3(u_xlat1);
    u_xlat12.xyz = u_xlat12.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
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
    u_xlat16_4.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat0.x = (-u_xlat16_4.y) + 1.0;
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
    u_xlat16_41 = u_xlat16_4.z + -1.0;
    u_xlat16_41 = _Occlusion * u_xlat16_41 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz;
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_6.x = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_6.x = (-u_xlat16_6.x) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xxx;
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
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_12.xyz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz * u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_42 = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_9.xyz = vec3(u_xlat16_42) * u_xlat16_8.xyz;
    u_xlat16_42 = (-u_xlat16_42) + 1.0;
    u_xlat16_42 = u_xlat16_4.y + u_xlat16_42;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_42 = min(max(u_xlat16_42, 0.0), 1.0);
#else
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_42);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_9.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_11.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_11.xyz = vec3(u_xlat16_41) * u_xlat16_11.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_11.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat1) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_9.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
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
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
mediump float u_xlat16_42;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat13.xyz = u_xlat12.xyz * vec3(u_xlat1);
    u_xlat12.xyz = u_xlat12.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
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
    u_xlat16_4.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat0.x = (-u_xlat16_4.y) + 1.0;
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
    u_xlat16_41 = u_xlat16_4.z + -1.0;
    u_xlat16_41 = _Occlusion * u_xlat16_41 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz;
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_6.x = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_6.x = (-u_xlat16_6.x) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xxx;
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
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_12.xyz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz * u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_42 = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_9.xyz = vec3(u_xlat16_42) * u_xlat16_8.xyz;
    u_xlat16_42 = (-u_xlat16_42) + 1.0;
    u_xlat16_42 = u_xlat16_4.y + u_xlat16_42;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_42 = min(max(u_xlat16_42, 0.0), 1.0);
#else
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_42);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_9.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _LightColor0.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_11.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_11.xyz = vec3(u_xlat16_41) * u_xlat16_11.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_11.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat1) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_9.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
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
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
float u_xlat27;
mediump float u_xlat16_27;
mediump float u_xlat16_36;
mediump float u_xlat16_38;
float u_xlat39;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_36 = u_xlat16_3.z + -1.0;
    u_xlat16_36 = _Occlusion * u_xlat16_36 + 1.0;
    u_xlat16_0.xyz = vec3(u_xlat16_36) * u_xlat16_0.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat4.xyz = vec3(u_xlat27) * u_xlat4.xyz;
    u_xlat16_2.x = dot((-u_xlat4.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat4.xyz);
    u_xlat16_1 = texture(_HeuristicReflection, u_xlat16_2.xyz);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = vec3(u_xlat16_36) * u_xlat16_2.xyz;
    u_xlat27 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xyz = vec3(u_xlat27) * vs_TEXCOORD1.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat39 = u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat4.xyz = u_xlat5.xyz * (-vec3(u_xlat27)) + u_xlat4.xyz;
    u_xlat27 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat27) * _LightColor0.xyz;
    u_xlat27 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat27 = u_xlat27 * u_xlat27;
    u_xlat4.x = u_xlat27 * u_xlat27;
    u_xlat16_36 = (-u_xlat39) + 1.0;
    u_xlat16_27 = u_xlat16_36 * u_xlat16_36;
    u_xlat16_27 = u_xlat16_36 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_36 * u_xlat16_27;
    u_xlat16_36 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_38 = (-u_xlat16_36) + 1.0;
    u_xlat16_38 = u_xlat16_38 + u_xlat16_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_38 = min(max(u_xlat16_38, 0.0), 1.0);
#else
    u_xlat16_38 = clamp(u_xlat16_38, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_7.xyz;
    u_xlat16_9.xyz = vec3(u_xlat16_36) * u_xlat16_5.xyz;
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat4.z = (-u_xlat16_3.y) + 1.0;
    u_xlat3.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_10.xyz = u_xlat3.xxx * u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat16_11.xyz = vec3(u_xlat16_38) + (-u_xlat16_8.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_27) * u_xlat16_11.xyz + u_xlat16_8.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_9.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_10.xyz * u_xlat16_6.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat39 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat39 = min(max(u_xlat39, 0.0), 1.0);
#else
    u_xlat39 = clamp(u_xlat39, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat39) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
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
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat12;
vec3 u_xlat13;
mediump float u_xlat16_13;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
float u_xlat30;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_27 = u_xlat16_3.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_29 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz;
    u_xlat16_29 = (-u_xlat16_29) + 1.0;
    u_xlat16_29 = u_xlat16_29 + u_xlat16_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.y) + 1.0;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat16_29);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat4.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat4.xxx;
    u_xlat4.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat13.xyz;
    u_xlat31 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat31 = max(u_xlat31, 0.319999993);
    u_xlat16_5.x = u_xlat16_3.x * u_xlat16_3.x + 1.5;
    u_xlat31 = u_xlat31 * u_xlat16_5.x;
    u_xlat5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_13 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_29 = u_xlat16_3.x * u_xlat16_13;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat16_3.x = u_xlat16_13 * u_xlat16_13 + -1.0;
    u_xlat3.x = u_xlat4.x * u_xlat16_3.x + 1.00001001;
    u_xlat3.x = u_xlat3.x * u_xlat31;
    u_xlat3.x = u_xlat16_13 / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + -9.99999975e-05;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = min(u_xlat3.x, 100.0);
    u_xlat4.xyz = u_xlat3.xxx * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _LightColor0.xyz;
    u_xlat3.x = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat31 = dot(u_xlat5.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_7.x = (-u_xlat31) + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_2.xyz = u_xlat16_7.xxx * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat3.xxx + u_xlat16_0.xyz;
    u_xlat16_0.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_0.xxx) + (-u_xlat12.xyz);
    u_xlat16_1 = texture(_HeuristicReflection, u_xlat16_0.xyz);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_29);
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
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
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat12;
vec3 u_xlat13;
mediump float u_xlat16_13;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
float u_xlat30;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_27 = u_xlat16_3.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_29 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz;
    u_xlat16_29 = (-u_xlat16_29) + 1.0;
    u_xlat16_29 = u_xlat16_29 + u_xlat16_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.y) + 1.0;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat16_29);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat4.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat4.xxx;
    u_xlat4.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat13.xyz;
    u_xlat31 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat31 = max(u_xlat31, 0.319999993);
    u_xlat16_5.x = u_xlat16_3.x * u_xlat16_3.x + 1.5;
    u_xlat31 = u_xlat31 * u_xlat16_5.x;
    u_xlat5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_13 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_29 = u_xlat16_3.x * u_xlat16_13;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat16_3.x = u_xlat16_13 * u_xlat16_13 + -1.0;
    u_xlat3.x = u_xlat4.x * u_xlat16_3.x + 1.00001001;
    u_xlat3.x = u_xlat3.x * u_xlat31;
    u_xlat3.x = u_xlat16_13 / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + -9.99999975e-05;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = min(u_xlat3.x, 100.0);
    u_xlat4.xyz = u_xlat3.xxx * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _LightColor0.xyz;
    u_xlat3.x = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat31 = dot(u_xlat5.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_7.x = (-u_xlat31) + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_2.xyz = u_xlat16_7.xxx * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat3.xxx + u_xlat16_0.xyz;
    u_xlat16_0.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_0.xxx) + (-u_xlat12.xyz);
    u_xlat16_1 = texture(_HeuristicReflection, u_xlat16_0.xyz);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_29);
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_14;
mediump vec3 u_xlat16_18;
float u_xlat33;
bool u_xlatb33;
float u_xlat35;
mediump float u_xlat16_38;
mediump float u_xlat16_39;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat33 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat33<9.99999975e-06);
#else
    u_xlatb33 = u_xlat33<9.99999975e-06;
#endif
    u_xlat33 = (u_xlatb33) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat2.z = u_xlat33 * u_xlat16_1.x;
    u_xlat3.x = u_xlat33 * u_xlat16_1.z;
    u_xlat2.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat33 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat33 = sin(u_xlat33);
    u_xlat33 = u_xlat33 * _NormalRand.w;
    u_xlat33 = fract(u_xlat33);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat33) + u_xlat16_1.xyz;
    u_xlat33 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat2.xyz;
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat4.z = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb33 = u_xlat4.z<0.00499999989;
#endif
    u_xlat35 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb33) ? 0.0 : u_xlat35;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_38 = u_xlat16_3.z + -1.0;
    u_xlat16_38 = _Occlusion * u_xlat16_38 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_38) * u_xlat16_5.xyz;
    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat35 = u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat35 = min(max(u_xlat35, 0.0), 1.0);
#else
    u_xlat35 = clamp(u_xlat35, 0.0, 1.0);
#endif
    u_xlat33 = u_xlat33 + u_xlat33;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat33)) + u_xlat0.xyz;
    u_xlat33 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat33) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_39 = (-u_xlat35) + 1.0;
    u_xlat16_11 = u_xlat16_39 * u_xlat16_39;
    u_xlat16_11 = u_xlat16_39 * u_xlat16_11;
    u_xlat16_11 = u_xlat16_39 * u_xlat16_11;
    u_xlat16_39 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.x = (-u_xlat16_39) + 1.0;
    u_xlat16_7.x = u_xlat16_3.y + u_xlat16_7.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_14.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_18.xyz = u_xlat16_2.xyz * u_xlat16_14.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_14.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_39) * u_xlat16_2.xyz;
    u_xlat16_18.xyz = u_xlat16_3.xxx * u_xlat16_18.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_9.xyz = (-u_xlat16_18.xyz) + u_xlat16_7.xxx;
    u_xlat16_9.xyz = vec3(u_xlat16_11) * u_xlat16_9.xyz + u_xlat16_18.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_18.xyz + u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_9.xyz;
    u_xlat16_39 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_39 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_39);
    u_xlat16_0 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_9.x = dot(unity_SHBr, u_xlat16_0);
    u_xlat16_9.y = dot(unity_SHBg, u_xlat16_0);
    u_xlat16_9.z = dot(unity_SHBb, u_xlat16_0);
    u_xlat16_9.xyz = unity_SHC.xyz * vec3(u_xlat16_39) + u_xlat16_9.xyz;
    u_xlat0.xyz = vs_TEXCOORD1.xyz;
    u_xlat0.w = 1.0;
    u_xlat16_10.x = dot(unity_SHAr, u_xlat0);
    u_xlat16_10.y = dot(unity_SHAg, u_xlat0);
    u_xlat16_10.z = dot(unity_SHAb, u_xlat0);
    u_xlat16_9.xyz = u_xlat16_9.xyz + u_xlat16_10.xyz;
    u_xlat16_9.xyz = max(u_xlat16_9.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = log2(u_xlat16_9.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9.xyz = unity_Lightmap_HDR.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_9.xyz = vec3(u_xlat16_38) * u_xlat16_9.xyz;
    u_xlat16_5.xyz = u_xlat16_9.xyz * u_xlat16_8.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat35 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat35 = min(max(u_xlat35, 0.0), 1.0);
#else
    u_xlat35 = clamp(u_xlat35, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat35) * u_xlat16_2.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat2.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
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
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat22;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_27 = u_xlat16_3.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_29 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz;
    u_xlat16_29 = (-u_xlat16_29) + 1.0;
    u_xlat16_29 = u_xlat16_29 + u_xlat16_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat16_3.y) + 1.0;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat16_29);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat4.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat4.xxx;
    u_xlat4.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat13.xyz;
    u_xlat31 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat31 = max(u_xlat31, 0.319999993);
    u_xlat5.x = u_xlat3.x * u_xlat3.x + 1.5;
    u_xlat31 = u_xlat31 * u_xlat5.x;
    u_xlat5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat13.x = u_xlat3.x * u_xlat3.x;
    u_xlat22 = u_xlat13.x * u_xlat13.x + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat22 + 1.00001001;
    u_xlat4.x = u_xlat4.x * u_xlat31;
    u_xlat4.x = u_xlat13.x / u_xlat4.x;
    u_xlat16_29 = u_xlat3.x * u_xlat13.x;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _LightColor0.xyz;
    u_xlat31 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = (-u_xlat5.x) + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_2.xyz = u_xlat16_7.xxx * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat3.x<0.00499999989);
#else
    u_xlatb31 = u_xlat3.x<0.00499999989;
#endif
    u_xlat3.x = u_xlat3.x * 8.29800034;
    u_xlat16_0.x = (u_xlatb31) ? 0.0 : u_xlat3.x;
    u_xlat16_9 = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_9 = u_xlat16_9 + u_xlat16_9;
    u_xlat16_7.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_9)) + (-u_xlat12.xyz);
    u_xlat3.x = dot(u_xlat16_7.zxy, (-u_xlat16_7.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<9.99999975e-06);
#else
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
#endif
    u_xlat3.x = (u_xlatb3) ? u_xlat16_7.z : (-u_xlat16_7.z);
    u_xlat5.z = u_xlat3.x * u_xlat16_7.x;
    u_xlat3.x = u_xlat3.x * u_xlat16_7.z;
    u_xlat5.xy = (-u_xlat16_7.xy) * u_xlat16_7.yz;
    u_xlat3.yz = (-u_xlat16_7.xy) * u_xlat16_7.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat5.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_29);
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz + unity_FogColor.xyz;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
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
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat22;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_27 = u_xlat16_3.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_29 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz;
    u_xlat16_29 = (-u_xlat16_29) + 1.0;
    u_xlat16_29 = u_xlat16_29 + u_xlat16_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat16_3.y) + 1.0;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat16_29);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat4.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat4.xxx;
    u_xlat4.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat13.xyz;
    u_xlat31 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat31 = max(u_xlat31, 0.319999993);
    u_xlat5.x = u_xlat3.x * u_xlat3.x + 1.5;
    u_xlat31 = u_xlat31 * u_xlat5.x;
    u_xlat5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat13.x = u_xlat3.x * u_xlat3.x;
    u_xlat22 = u_xlat13.x * u_xlat13.x + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat22 + 1.00001001;
    u_xlat4.x = u_xlat4.x * u_xlat31;
    u_xlat4.x = u_xlat13.x / u_xlat4.x;
    u_xlat16_29 = u_xlat3.x * u_xlat13.x;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat4.xyz = u_xlat4.xyz * _LightColor0.xyz;
    u_xlat31 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = (-u_xlat5.x) + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_2.xyz = u_xlat16_7.xxx * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat3.x<0.00499999989);
#else
    u_xlatb31 = u_xlat3.x<0.00499999989;
#endif
    u_xlat3.x = u_xlat3.x * 8.29800034;
    u_xlat16_0.x = (u_xlatb31) ? 0.0 : u_xlat3.x;
    u_xlat16_9 = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_9 = u_xlat16_9 + u_xlat16_9;
    u_xlat16_7.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_9)) + (-u_xlat12.xyz);
    u_xlat3.x = dot(u_xlat16_7.zxy, (-u_xlat16_7.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<9.99999975e-06);
#else
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
#endif
    u_xlat3.x = (u_xlatb3) ? u_xlat16_7.z : (-u_xlat16_7.z);
    u_xlat5.z = u_xlat3.x * u_xlat16_7.x;
    u_xlat3.x = u_xlat3.x * u_xlat16_7.z;
    u_xlat5.xy = (-u_xlat16_7.xy) * u_xlat16_7.yz;
    u_xlat3.yz = (-u_xlat16_7.xy) * u_xlat16_7.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat5.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_29);
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
mediump float u_xlat16_15;
float u_xlat23;
float u_xlat30;
mediump float u_xlat16_32;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat16_1 = texture(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_32 = u_xlat16_3.z + -1.0;
    u_xlat16_32 = _Occlusion * u_xlat16_32 + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_32) * u_xlat16_2.xyz;
    u_xlat30 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat4.xyz = vec3(u_xlat30) * vs_TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat23 = u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = u_xlat4.xyz * (-vec3(u_xlat30)) + u_xlat0.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_5.x = (-u_xlat23) + 1.0;
    u_xlat16_10 = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_10 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_10 = u_xlat16_5.x * u_xlat16_10;
    u_xlat16_5.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_15 = (-u_xlat16_5.x) + 1.0;
    u_xlat16_15 = u_xlat16_3.y + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz;
    u_xlat16_5.xzw = u_xlat16_5.xxx * u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.z = (-u_xlat16_3.y) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_8.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_5.xzw;
    u_xlat16_9.xyz = vec3(u_xlat16_15) + (-u_xlat16_7.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_10) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_32) * u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_7.xyz * u_xlat16_5.xzw + u_xlat16_2.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_32 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat16_32) * _LightColor0.xyz;
    u_xlat16_5.xyz = vec3(u_xlat30) * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_8.xyz * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_12;
mediump float u_xlat16_22;
float u_xlat30;
mediump float u_xlat16_31;
float u_xlat32;
mediump float u_xlat16_32;
float u_xlat33;
mediump float u_xlat16_33;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat30 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = max(u_xlat30, 0.319999993);
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_32 = (-u_xlat16_3.y) + 1.0;
    u_xlat16_33 = u_xlat16_32 * u_xlat16_32 + 1.5;
    u_xlat30 = u_xlat30 * u_xlat16_33;
    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_12 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_31 = u_xlat16_32 * u_xlat16_12;
    u_xlat16_31 = (-u_xlat16_31) * 0.280000001 + 1.0;
    u_xlat16_22 = u_xlat16_12 * u_xlat16_12 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat16_22 + 1.00001001;
    u_xlat30 = u_xlat30 * u_xlat2.x;
    u_xlat30 = u_xlat16_12 / u_xlat30;
    u_xlat30 = u_xlat30 + -9.99999975e-05;
    u_xlat30 = max(u_xlat30, 0.0);
    u_xlat30 = min(u_xlat30, 100.0);
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_37 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_8.xyz = u_xlat16_6.xyz * vec3(u_xlat16_37);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = u_xlat16_3.y + u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_3.z + -1.0;
    u_xlat16_38 = _Occlusion * u_xlat16_38 + 1.0;
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_37);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat32 = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat32) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_8.xyz * u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat16_7.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_7.xxx) + (-u_xlat0.xyz);
    u_xlat16_0 = texture(_HeuristicReflection, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_0.w + -1.0;
    u_xlat16_7.x = unity_SpecCube0_HDR.w * u_xlat16_7.x + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_12;
mediump float u_xlat16_22;
float u_xlat30;
mediump float u_xlat16_31;
float u_xlat32;
mediump float u_xlat16_32;
float u_xlat33;
mediump float u_xlat16_33;
mediump float u_xlat16_37;
mediump float u_xlat16_38;
void main()
{
    u_xlat16_0 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_1.x = dot(u_xlat16_0, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xxx * _LightColor0.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat30) + _WorldSpaceLightPos0.xyz;
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = max(u_xlat30, 0.00100000005);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat30 = dot(_WorldSpaceLightPos0.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat30 = max(u_xlat30, 0.319999993);
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_32 = (-u_xlat16_3.y) + 1.0;
    u_xlat16_33 = u_xlat16_32 * u_xlat16_32 + 1.5;
    u_xlat30 = u_xlat30 * u_xlat16_33;
    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
    u_xlat2.x = dot(u_xlat4.xyz, u_xlat2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_12 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_31 = u_xlat16_32 * u_xlat16_12;
    u_xlat16_31 = (-u_xlat16_31) * 0.280000001 + 1.0;
    u_xlat16_22 = u_xlat16_12 * u_xlat16_12 + -1.0;
    u_xlat2.x = u_xlat2.x * u_xlat16_22 + 1.00001001;
    u_xlat30 = u_xlat30 * u_xlat2.x;
    u_xlat30 = u_xlat16_12 / u_xlat30;
    u_xlat30 = u_xlat30 + -9.99999975e-05;
    u_xlat30 = max(u_xlat30, 0.0);
    u_xlat30 = min(u_xlat30, 100.0);
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_37 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_8.xyz = u_xlat16_6.xyz * vec3(u_xlat16_37);
    u_xlat16_37 = (-u_xlat16_37) + 1.0;
    u_xlat16_37 = u_xlat16_3.y + u_xlat16_37;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_37 = min(max(u_xlat16_37, 0.0), 1.0);
#else
    u_xlat16_37 = clamp(u_xlat16_37, 0.0, 1.0);
#endif
    u_xlat16_38 = u_xlat16_3.z + -1.0;
    u_xlat16_38 = _Occlusion * u_xlat16_38 + 1.0;
    u_xlat16_9.xyz = (-u_xlat16_7.xyz) + vec3(u_xlat16_37);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat32 = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat16_1.x = (-u_xlat32) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_3.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat16_8.xyz * u_xlat16_7.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat16_7.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_7.x = u_xlat16_7.x + u_xlat16_7.x;
    u_xlat16_7.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_7.xxx) + (-u_xlat0.xyz);
    u_xlat16_0 = texture(_HeuristicReflection, u_xlat16_7.xyz);
    u_xlat16_7.x = u_xlat16_0.w + -1.0;
    u_xlat16_7.x = unity_SpecCube0_HDR.w * u_xlat16_7.x + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * unity_SpecCube0_HDR.x;
    u_xlat16_7.xyz = u_xlat16_0.xyz * u_xlat16_7.xxx;
    u_xlat16_7.xyz = vec3(u_xlat16_38) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_31) * u_xlat16_7.xyz;
    u_xlat0.xyz = u_xlat16_7.xyz * u_xlat16_1.xyz + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
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
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
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
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_15;
float u_xlat27;
bool u_xlatb27;
float u_xlat29;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat4.z = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb27 = u_xlat4.z<0.00499999989;
#endif
    u_xlat29 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb27) ? 0.0 : u_xlat29;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_32 = u_xlat16_3.z + -1.0;
    u_xlat16_32 = _Occlusion * u_xlat16_32 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_32) * u_xlat16_5.xyz;
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
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_6.x = (-u_xlat29) + 1.0;
    u_xlat16_9 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_9 = u_xlat16_6.x * u_xlat16_9;
    u_xlat16_9 = u_xlat16_6.x * u_xlat16_9;
    u_xlat16_6.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_15 = (-u_xlat16_6.x) + 1.0;
    u_xlat16_15 = u_xlat16_3.y + u_xlat16_15;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_12.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_12.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_12.xyz;
    u_xlat16_6.xzw = u_xlat16_6.xxx * u_xlat16_2.xyz;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_15) + (-u_xlat16_7.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_9) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xzw;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_8.xyz = vec3(u_xlat16_32) * u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_8.xyz * u_xlat16_6.xzw + u_xlat16_5.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_32 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_32) * _LightColor0.xyz;
    u_xlat16_6.xyz = vec3(u_xlat27) * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_0.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat27 = vs_TEXCOORD4;
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
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
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
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
mediump float u_xlat16_42;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat13.xyz = u_xlat12.xyz * vec3(u_xlat1);
    u_xlat12.xyz = u_xlat12.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
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
    u_xlat16_4.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat0.x = (-u_xlat16_4.y) + 1.0;
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
    u_xlat16_41 = u_xlat16_4.z + -1.0;
    u_xlat16_41 = _Occlusion * u_xlat16_41 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz;
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_6.x = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_6.x = (-u_xlat16_6.x) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xxx;
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
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_12.xyz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz * u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_42 = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_9.xyz = vec3(u_xlat16_42) * u_xlat16_8.xyz;
    u_xlat16_42 = (-u_xlat16_42) + 1.0;
    u_xlat16_42 = u_xlat16_4.y + u_xlat16_42;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_42 = min(max(u_xlat16_42, 0.0), 1.0);
#else
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_42);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_9.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_42 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_42 = min(max(u_xlat16_42, 0.0), 1.0);
#else
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
#endif
    u_xlat16_11.xyz = vec3(u_xlat16_42) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_11.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_11.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_11.xyz = vec3(u_xlat16_41) * u_xlat16_11.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_11.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat1) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_9.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD5;
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
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
vec3 u_xlat12;
mediump vec3 u_xlat16_12;
vec3 u_xlat13;
float u_xlat24;
float u_xlat36;
float u_xlat39;
mediump float u_xlat16_41;
mediump float u_xlat16_42;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _NormalRand.w;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat1 = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat1 = inversesqrt(u_xlat1);
    u_xlat13.xyz = u_xlat12.xyz * vec3(u_xlat1);
    u_xlat12.xyz = u_xlat12.xyz * vec3(u_xlat1) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat13.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat13.xyz);
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
    u_xlat16_4.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat0.x = (-u_xlat16_4.y) + 1.0;
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
    u_xlat16_41 = u_xlat16_4.z + -1.0;
    u_xlat16_41 = _Occlusion * u_xlat16_41 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_41) * u_xlat16_5.xyz;
    u_xlat1 = u_xlat0.x * u_xlat0.x;
    u_xlat16_6.x = u_xlat0.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat0.x + 1.5;
    u_xlat16_6.x = (-u_xlat16_6.x) * 0.280000001 + 1.0;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xxx;
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
    u_xlat24 = u_xlat1 * u_xlat1 + -1.0;
    u_xlat12.x = u_xlat12.x * u_xlat24 + 1.00001001;
    u_xlat0.x = u_xlat12.x * u_xlat0.x;
    u_xlat0.x = u_xlat1 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_12.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_7.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_8.xyz = u_xlat16_12.xyz * u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_12.xyz * u_xlat16_7.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_6.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_42 = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_9.xyz = vec3(u_xlat16_42) * u_xlat16_8.xyz;
    u_xlat16_42 = (-u_xlat16_42) + 1.0;
    u_xlat16_42 = u_xlat16_4.y + u_xlat16_42;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_42 = min(max(u_xlat16_42, 0.0), 1.0);
#else
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
#endif
    u_xlat16_10.xyz = (-u_xlat16_6.xyz) + vec3(u_xlat16_42);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_6.xyz + u_xlat16_9.xyz;
    u_xlat16_2 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_42 = dot(u_xlat16_2, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_42 = min(max(u_xlat16_42, 0.0), 1.0);
#else
    u_xlat16_42 = clamp(u_xlat16_42, 0.0, 1.0);
#endif
    u_xlat16_11.xyz = vec3(u_xlat16_42) * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_11.xyz;
    u_xlat16_4.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_11.xyz = u_xlat16_4.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_11.xyz = vec3(u_xlat16_41) * u_xlat16_11.xyz;
    u_xlat16_9.xyz = u_xlat16_9.xyz * u_xlat16_11.xyz;
    u_xlat36 = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat1 = dot(u_xlat3.xyz, u_xlat13.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat16_41 = (-u_xlat1) + 1.0;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_41 = u_xlat16_41 * u_xlat16_41;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * u_xlat16_10.xyz + u_xlat16_6.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat16_9.xyz;
    u_xlat0.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
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
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat25;
mediump float u_xlat16_33;
mediump float u_xlat16_35;
float u_xlat36;
mediump float u_xlat16_36;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_33 = u_xlat16_3.z + -1.0;
    u_xlat16_33 = _Occlusion * u_xlat16_33 + 1.0;
    u_xlat16_0.xyz = vec3(u_xlat16_33) * u_xlat16_0.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
    u_xlat16_2.x = dot((-u_xlat4.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat4.xyz);
    u_xlat16_1 = texture(_HeuristicReflection, u_xlat16_2.xyz);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = vec3(u_xlat16_33) * u_xlat16_2.xyz;
    u_xlat25 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat5.xyz = vec3(u_xlat25) * vs_TEXCOORD1.xyz;
    u_xlat25 = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat36 = u_xlat25;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat25 = u_xlat25 + u_xlat25;
    u_xlat4.xyz = u_xlat5.xyz * (-vec3(u_xlat25)) + u_xlat4.xyz;
    u_xlat25 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat4.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_33 = (-u_xlat36) + 1.0;
    u_xlat16_36 = u_xlat16_33 * u_xlat16_33;
    u_xlat16_36 = u_xlat16_33 * u_xlat16_36;
    u_xlat16_36 = u_xlat16_33 * u_xlat16_36;
    u_xlat16_33 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_35 = (-u_xlat16_33) + 1.0;
    u_xlat16_35 = u_xlat16_35 + u_xlat16_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_6.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_33) * u_xlat16_5.xyz;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat4.z = (-u_xlat16_3.y) + 1.0;
    u_xlat3.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat3.x = u_xlat3.x * 16.0;
    u_xlat16_9.xyz = u_xlat3.xxx * u_xlat16_7.xyz + u_xlat16_8.xyz;
    u_xlat16_10.xyz = vec3(u_xlat16_35) + (-u_xlat16_7.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_36) * u_xlat16_10.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_33 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_33 = min(max(u_xlat16_33, 0.0), 1.0);
#else
    u_xlat16_33 = clamp(u_xlat16_33, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_33) * _LightColor0.xyz;
    u_xlat16_2.xyz = vec3(u_xlat25) * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_9.xyz * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat36 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat36 = min(max(u_xlat36, 0.0), 1.0);
#else
    u_xlat36 = clamp(u_xlat36, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat36) * u_xlat16_3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
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
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat12;
vec3 u_xlat13;
mediump float u_xlat16_13;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
float u_xlat30;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_27 = u_xlat16_3.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_29 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz;
    u_xlat16_29 = (-u_xlat16_29) + 1.0;
    u_xlat16_29 = u_xlat16_29 + u_xlat16_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.y) + 1.0;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat16_29);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat4.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat4.xxx;
    u_xlat4.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat13.xyz;
    u_xlat31 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat31 = max(u_xlat31, 0.319999993);
    u_xlat16_5.x = u_xlat16_3.x * u_xlat16_3.x + 1.5;
    u_xlat31 = u_xlat31 * u_xlat16_5.x;
    u_xlat5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_13 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_29 = u_xlat16_3.x * u_xlat16_13;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat16_3.x = u_xlat16_13 * u_xlat16_13 + -1.0;
    u_xlat3.x = u_xlat4.x * u_xlat16_3.x + 1.00001001;
    u_xlat3.x = u_xlat3.x * u_xlat31;
    u_xlat3.x = u_xlat16_13 / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + -9.99999975e-05;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = min(u_xlat3.x, 100.0);
    u_xlat4.xyz = u_xlat3.xxx * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_7.x = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = u_xlat16_7.xxx * _LightColor0.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_7.xyz;
    u_xlat3.x = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat31 = dot(u_xlat5.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_7.x = (-u_xlat31) + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_2.xyz = u_xlat16_7.xxx * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat3.xxx + u_xlat16_0.xyz;
    u_xlat16_0.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_0.xxx) + (-u_xlat12.xyz);
    u_xlat16_1 = texture(_HeuristicReflection, u_xlat16_0.xyz);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_29);
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
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
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat12;
vec3 u_xlat13;
mediump float u_xlat16_13;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
float u_xlat30;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_27 = u_xlat16_3.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_29 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz;
    u_xlat16_29 = (-u_xlat16_29) + 1.0;
    u_xlat16_29 = u_xlat16_29 + u_xlat16_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.y) + 1.0;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat16_29);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat4.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat4.xxx;
    u_xlat4.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat13.xyz;
    u_xlat31 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat31 = max(u_xlat31, 0.319999993);
    u_xlat16_5.x = u_xlat16_3.x * u_xlat16_3.x + 1.5;
    u_xlat31 = u_xlat31 * u_xlat16_5.x;
    u_xlat5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat16_13 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_29 = u_xlat16_3.x * u_xlat16_13;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat16_3.x = u_xlat16_13 * u_xlat16_13 + -1.0;
    u_xlat3.x = u_xlat4.x * u_xlat16_3.x + 1.00001001;
    u_xlat3.x = u_xlat3.x * u_xlat31;
    u_xlat3.x = u_xlat16_13 / u_xlat3.x;
    u_xlat3.x = u_xlat3.x + -9.99999975e-05;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = min(u_xlat3.x, 100.0);
    u_xlat4.xyz = u_xlat3.xxx * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_7.x = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = u_xlat16_7.xxx * _LightColor0.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_7.xyz;
    u_xlat3.x = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat31 = dot(u_xlat5.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat16_7.x = (-u_xlat31) + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_2.xyz = u_xlat16_7.xxx * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat3.xxx + u_xlat16_0.xyz;
    u_xlat16_0.x = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_0.x = u_xlat16_0.x + u_xlat16_0.x;
    u_xlat16_0.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_0.xxx) + (-u_xlat12.xyz);
    u_xlat16_1 = texture(_HeuristicReflection, u_xlat16_0.xyz);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_29);
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
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
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
mediump vec3 u_xlat16_13;
mediump float u_xlat16_16;
float u_xlat30;
bool u_xlatb30;
float u_xlat32;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat30 = dot(u_xlat16_1.zxy, (-u_xlat16_1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat30<9.99999975e-06);
#else
    u_xlatb30 = u_xlat30<9.99999975e-06;
#endif
    u_xlat30 = (u_xlatb30) ? u_xlat16_1.z : (-u_xlat16_1.z);
    u_xlat2.z = u_xlat30 * u_xlat16_1.x;
    u_xlat3.x = u_xlat30 * u_xlat16_1.z;
    u_xlat2.xy = (-u_xlat16_1.xy) * u_xlat16_1.yz;
    u_xlat3.yz = (-u_xlat16_1.xy) * u_xlat16_1.xy;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat3.xyz);
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat30) + u_xlat16_1.xyz;
    u_xlat30 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * u_xlat2.xyz;
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat4.z = (-u_xlat16_3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb30 = !!(u_xlat4.z<0.00499999989);
#else
    u_xlatb30 = u_xlat4.z<0.00499999989;
#endif
    u_xlat32 = u_xlat4.z * 8.29800034;
    u_xlat16_1.x = (u_xlatb30) ? 0.0 : u_xlat32;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat2.xyz, u_xlat16_1.x);
    u_xlat16_5.x = u_xlat16_1.w + -1.0;
    u_xlat16_5.x = unity_SpecCube0_HDR.w * u_xlat16_5.x + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_1.xyz * u_xlat16_5.xxx;
    u_xlat16_35 = u_xlat16_3.z + -1.0;
    u_xlat16_35 = _Occlusion * u_xlat16_35 + 1.0;
    u_xlat16_5.xyz = vec3(u_xlat16_35) * u_xlat16_5.xyz;
    u_xlat30 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat2.xyz = vec3(u_xlat30) * vs_TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat32 = u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlat32 = min(max(u_xlat32, 0.0), 1.0);
#else
    u_xlat32 = clamp(u_xlat32, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = u_xlat2.xyz * (-vec3(u_xlat30)) + u_xlat0.xyz;
    u_xlat30 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat4.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat4.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_6.x = (-u_xlat32) + 1.0;
    u_xlat16_10 = u_xlat16_6.x * u_xlat16_6.x;
    u_xlat16_10 = u_xlat16_6.x * u_xlat16_10;
    u_xlat16_10 = u_xlat16_6.x * u_xlat16_10;
    u_xlat16_6.x = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_16 = (-u_xlat16_6.x) + 1.0;
    u_xlat16_16 = u_xlat16_3.y + u_xlat16_16;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_13.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_2.xyz * u_xlat16_13.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_13.xyz;
    u_xlat16_6.xzw = u_xlat16_6.xxx * u_xlat16_2.xyz;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_8.xyz = vec3(u_xlat16_16) + (-u_xlat16_7.xyz);
    u_xlat16_8.xyz = vec3(u_xlat16_10) * u_xlat16_8.xyz + u_xlat16_7.xyz;
    u_xlat16_7.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_6.xzw;
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_8.xyz;
    u_xlat16_16 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
    u_xlat16_16 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat16_16);
    u_xlat16_1 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
    u_xlat16_8.x = dot(unity_SHBr, u_xlat16_1);
    u_xlat16_8.y = dot(unity_SHBg, u_xlat16_1);
    u_xlat16_8.z = dot(unity_SHBb, u_xlat16_1);
    u_xlat16_8.xyz = unity_SHC.xyz * vec3(u_xlat16_16) + u_xlat16_8.xyz;
    u_xlat1.xyz = vs_TEXCOORD1.xyz;
    u_xlat1.w = 1.0;
    u_xlat16_9.x = dot(unity_SHAr, u_xlat1);
    u_xlat16_9.y = dot(unity_SHAg, u_xlat1);
    u_xlat16_9.z = dot(unity_SHAb, u_xlat1);
    u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = max(u_xlat16_8.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_0.xyz = log2(u_xlat16_8.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
    u_xlat16_0.xyz = exp2(u_xlat16_0.xyz);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
    u_xlat16_0.xyz = max(u_xlat16_0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat16_2.xyz = texture(unity_Lightmap, vs_TEXCOORD3.xy).xyz;
    u_xlat16_8.xyz = unity_Lightmap_HDR.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_8.xyz = vec3(u_xlat16_35) * u_xlat16_8.xyz;
    u_xlat16_5.xyz = u_xlat16_8.xyz * u_xlat16_6.xzw + u_xlat16_5.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_35 = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = vec3(u_xlat16_35) * _LightColor0.xyz;
    u_xlat16_6.xyz = vec3(u_xlat30) * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_7.xyz * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_0.xyz = u_xlat16_5.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
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
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
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
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat22;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_27 = u_xlat16_3.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_29 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz;
    u_xlat16_29 = (-u_xlat16_29) + 1.0;
    u_xlat16_29 = u_xlat16_29 + u_xlat16_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat16_3.y) + 1.0;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat16_29);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat4.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat4.xxx;
    u_xlat4.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat13.xyz;
    u_xlat31 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat31 = max(u_xlat31, 0.319999993);
    u_xlat5.x = u_xlat3.x * u_xlat3.x + 1.5;
    u_xlat31 = u_xlat31 * u_xlat5.x;
    u_xlat5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat13.x = u_xlat3.x * u_xlat3.x;
    u_xlat22 = u_xlat13.x * u_xlat13.x + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat22 + 1.00001001;
    u_xlat4.x = u_xlat4.x * u_xlat31;
    u_xlat4.x = u_xlat13.x / u_xlat4.x;
    u_xlat16_29 = u_xlat3.x * u_xlat13.x;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_7.x = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = u_xlat16_7.xxx * _LightColor0.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_7.xyz;
    u_xlat31 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = (-u_xlat5.x) + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_2.xyz = u_xlat16_7.xxx * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat3.x<0.00499999989);
#else
    u_xlatb31 = u_xlat3.x<0.00499999989;
#endif
    u_xlat3.x = u_xlat3.x * 8.29800034;
    u_xlat16_0.x = (u_xlatb31) ? 0.0 : u_xlat3.x;
    u_xlat16_9 = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_9 = u_xlat16_9 + u_xlat16_9;
    u_xlat16_7.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_9)) + (-u_xlat12.xyz);
    u_xlat3.x = dot(u_xlat16_7.zxy, (-u_xlat16_7.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<9.99999975e-06);
#else
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
#endif
    u_xlat3.x = (u_xlatb3) ? u_xlat16_7.z : (-u_xlat16_7.z);
    u_xlat5.z = u_xlat3.x * u_xlat16_7.x;
    u_xlat3.x = u_xlat3.x * u_xlat16_7.z;
    u_xlat5.xy = (-u_xlat16_7.xy) * u_xlat16_7.yz;
    u_xlat3.yz = (-u_xlat16_7.xy) * u_xlat16_7.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat5.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_29);
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz + unity_FogColor.xyz;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	vec4 _NormalRand;
uniform 	mediump float _NormalDiff;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump sampler2D unity_Lightmap;
uniform mediump sampler2D unity_ShadowMask;
uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
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
bool u_xlatb3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_9;
vec3 u_xlat12;
vec3 u_xlat13;
float u_xlat22;
mediump float u_xlat16_27;
mediump float u_xlat16_29;
float u_xlat30;
float u_xlat31;
bool u_xlatb31;
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
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_27 = u_xlat16_3.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_5.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_2.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_29 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_7.xyz = vec3(u_xlat16_29) * u_xlat16_6.xyz;
    u_xlat16_29 = (-u_xlat16_29) + 1.0;
    u_xlat16_29 = u_xlat16_29 + u_xlat16_3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_29 = min(max(u_xlat16_29, 0.0), 1.0);
#else
    u_xlat16_29 = clamp(u_xlat16_29, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat16_3.y) + 1.0;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat16_29);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_7.xyz;
    u_xlat12.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat4.x = dot(u_xlat12.xyz, u_xlat12.xyz);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat13.xyz = u_xlat12.xyz * u_xlat4.xxx + _WorldSpaceLightPos0.xyz;
    u_xlat12.xyz = u_xlat12.xyz * u_xlat4.xxx;
    u_xlat4.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat4.x = max(u_xlat4.x, 0.00100000005);
    u_xlat4.x = inversesqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat13.xyz;
    u_xlat31 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat31 = max(u_xlat31, 0.319999993);
    u_xlat5.x = u_xlat3.x * u_xlat3.x + 1.5;
    u_xlat31 = u_xlat31 * u_xlat5.x;
    u_xlat5.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
    u_xlat4.x = dot(u_xlat5.xyz, u_xlat4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat4.x * u_xlat4.x;
    u_xlat13.x = u_xlat3.x * u_xlat3.x;
    u_xlat22 = u_xlat13.x * u_xlat13.x + -1.0;
    u_xlat4.x = u_xlat4.x * u_xlat22 + 1.00001001;
    u_xlat4.x = u_xlat4.x * u_xlat31;
    u_xlat4.x = u_xlat13.x / u_xlat4.x;
    u_xlat16_29 = u_xlat3.x * u_xlat13.x;
    u_xlat16_29 = (-u_xlat16_29) * 0.280000001 + 1.0;
    u_xlat4.x = u_xlat4.x + -9.99999975e-05;
    u_xlat4.x = max(u_xlat4.x, 0.0);
    u_xlat4.x = min(u_xlat4.x, 100.0);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat16_2.xyz + u_xlat16_7.xyz;
    u_xlat16_1 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
    u_xlat16_7.x = dot(u_xlat16_1, unity_OcclusionMaskSelector);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.x = min(max(u_xlat16_7.x, 0.0), 1.0);
#else
    u_xlat16_7.x = clamp(u_xlat16_7.x, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = u_xlat16_7.xxx * _LightColor0.xyz;
    u_xlat4.xyz = u_xlat4.xyz * u_xlat16_7.xyz;
    u_xlat31 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat31 = min(max(u_xlat31, 0.0), 1.0);
#else
    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
#endif
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat12.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = (-u_xlat5.x) + 1.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_2.xyz = u_xlat16_7.xxx * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat31) + u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb31 = !!(u_xlat3.x<0.00499999989);
#else
    u_xlatb31 = u_xlat3.x<0.00499999989;
#endif
    u_xlat3.x = u_xlat3.x * 8.29800034;
    u_xlat16_0.x = (u_xlatb31) ? 0.0 : u_xlat3.x;
    u_xlat16_9 = dot((-u_xlat12.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_9 = u_xlat16_9 + u_xlat16_9;
    u_xlat16_7.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat16_9)) + (-u_xlat12.xyz);
    u_xlat3.x = dot(u_xlat16_7.zxy, (-u_xlat16_7.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<9.99999975e-06);
#else
    u_xlatb3 = u_xlat3.x<9.99999975e-06;
#endif
    u_xlat3.x = (u_xlatb3) ? u_xlat16_7.z : (-u_xlat16_7.z);
    u_xlat5.z = u_xlat3.x * u_xlat16_7.x;
    u_xlat3.x = u_xlat3.x * u_xlat16_7.z;
    u_xlat5.xy = (-u_xlat16_7.xy) * u_xlat16_7.yz;
    u_xlat3.yz = (-u_xlat16_7.xy) * u_xlat16_7.xy;
    u_xlat3.xyz = (-u_xlat3.xyz) + u_xlat5.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(_NormalDiff);
    u_xlat30 = dot(vs_TEXCOORD2.xyz, _NormalRand.xyz);
    u_xlat30 = sin(u_xlat30);
    u_xlat30 = u_xlat30 * _NormalRand.w;
    u_xlat30 = fract(u_xlat30);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat30) + u_xlat16_7.xyz;
    u_xlat30 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz;
    u_xlat16_1 = texture(unity_SpecCube0, u_xlat3.xyz, u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_1.w + -1.0;
    u_xlat16_0.x = unity_SpecCube0_HDR.w * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * unity_SpecCube0_HDR.x;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_29);
    u_xlat3.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat30) * u_xlat3.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_10;
float u_xlat23;
float u_xlat30;
mediump float u_xlat16_32;
mediump float u_xlat16_35;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
    u_xlat16_1.x = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_1.xxx) + (-u_xlat0.xyz);
    u_xlat16_1 = texture(_HeuristicReflection, u_xlat16_1.xyz);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
    u_xlat16_3.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_32 = u_xlat16_3.z + -1.0;
    u_xlat16_32 = _Occlusion * u_xlat16_32 + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_32) * u_xlat16_2.xyz;
    u_xlat30 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat4.xyz = vec3(u_xlat30) * vs_TEXCOORD1.xyz;
    u_xlat30 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat23 = u_xlat30;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat30 = u_xlat30 + u_xlat30;
    u_xlat0.xyz = u_xlat4.xyz * (-vec3(u_xlat30)) + u_xlat0.xyz;
    u_xlat30 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat30) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_32 = (-u_xlat23) + 1.0;
    u_xlat16_10 = u_xlat16_32 * u_xlat16_32;
    u_xlat16_10 = u_xlat16_32 * u_xlat16_10;
    u_xlat16_10 = u_xlat16_32 * u_xlat16_10;
    u_xlat16_32 = (-u_xlat16_3.x) * 0.779083729 + 0.779083729;
    u_xlat16_35 = (-u_xlat16_32) + 1.0;
    u_xlat16_35 = u_xlat16_3.y + u_xlat16_35;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_35 = min(max(u_xlat16_35, 0.0), 1.0);
#else
    u_xlat16_35 = clamp(u_xlat16_35, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_3.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat0.z = (-u_xlat16_3.y) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xz).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat16_8.xyz = u_xlat16_4.xyz * vec3(u_xlat16_32) + u_xlat16_8.xyz;
    u_xlat16_9.xyz = vec3(u_xlat16_35) + (-u_xlat16_7.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_10) * u_xlat16_9.xyz + u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_7.xyz;
    u_xlat16_2.xyz = u_xlat16_8.xyz * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat30 = vs_TEXCOORD4;
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
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_14;
float u_xlat16;
float u_xlat20;
float u_xlat24;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
mediump float u_xlat16_27;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat1.xyz);
    u_xlat16_2 = texture(_HeuristicReflection, u_xlat16_2.xyz);
    u_xlat16_3.x = u_xlat16_2.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat16_3.xxx;
    u_xlat16_4.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_27 = u_xlat16_4.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_3.xyz = vec3(u_xlat16_27) * u_xlat16_3.xyz;
    u_xlat16_24 = (-u_xlat16_4.y) + 1.0;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_27 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24 + 1.5;
    u_xlat16_27 = (-u_xlat16_27) * 0.280000001 + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_27);
    u_xlat20 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat5.xyz = vec3(u_xlat20) * vs_TEXCOORD1.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_27 = (-u_xlat1.x) + 1.0;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_6 = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_14.x = (-u_xlat16_6) + 1.0;
    u_xlat16_14.x = u_xlat16_4.y + u_xlat16_14.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14.x = min(max(u_xlat16_14.x, 0.0), 1.0);
#else
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_12.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat16_12.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_12.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_14.xyz = u_xlat16_14.xxx + (-u_xlat16_7.xyz);
    u_xlat16_14.xyz = vec3(u_xlat16_27) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_14.xyz;
    u_xlat4 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = max(u_xlat4, 0.00100000005);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat4);
    u_xlat4 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16 = max(u_xlat4, 0.319999993);
    u_xlat16 = u_xlat16_24 * u_xlat16;
    u_xlat16_24 = u_xlat16_25 * u_xlat16_25 + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_24 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat16;
    u_xlat0.x = u_xlat16_25 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xzw = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xzw = u_xlat16_1.xyz * vec3(u_xlat16_6) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat8) + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD4;
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
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD4;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD4 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Occlusion;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform mediump samplerCube _HeuristicReflection;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat8;
mediump vec3 u_xlat16_12;
mediump vec3 u_xlat16_14;
float u_xlat16;
float u_xlat20;
float u_xlat24;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
mediump float u_xlat16_27;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
    u_xlat16_2.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
    u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz * (-u_xlat16_2.xxx) + (-u_xlat1.xyz);
    u_xlat16_2 = texture(_HeuristicReflection, u_xlat16_2.xyz);
    u_xlat16_3.x = u_xlat16_2.w + -1.0;
    u_xlat16_3.x = unity_SpecCube0_HDR.w * u_xlat16_3.x + 1.0;
    u_xlat16_3.x = u_xlat16_3.x * unity_SpecCube0_HDR.x;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat16_3.xxx;
    u_xlat16_4.xyz = texture(_MSA, vs_TEXCOORD0.zw).xyz;
    u_xlat16_27 = u_xlat16_4.z + -1.0;
    u_xlat16_27 = _Occlusion * u_xlat16_27 + 1.0;
    u_xlat16_3.xyz = vec3(u_xlat16_27) * u_xlat16_3.xyz;
    u_xlat16_24 = (-u_xlat16_4.y) + 1.0;
    u_xlat16_25 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_27 = u_xlat16_24 * u_xlat16_25;
    u_xlat16_24 = u_xlat16_24 * u_xlat16_24 + 1.5;
    u_xlat16_27 = (-u_xlat16_27) * 0.280000001 + 1.0;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat16_27);
    u_xlat20 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat5.xyz = vec3(u_xlat20) * vs_TEXCOORD1.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_27 = (-u_xlat1.x) + 1.0;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_6 = (-u_xlat16_4.x) * 0.779083729 + 0.779083729;
    u_xlat16_14.x = (-u_xlat16_6) + 1.0;
    u_xlat16_14.x = u_xlat16_4.y + u_xlat16_14.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14.x = min(max(u_xlat16_14.x, 0.0), 1.0);
#else
    u_xlat16_14.x = clamp(u_xlat16_14.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_12.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat16_12.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_12.xyz;
    u_xlat16_7.xyz = u_xlat16_4.xxx * u_xlat16_7.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_14.xyz = u_xlat16_14.xxx + (-u_xlat16_7.xyz);
    u_xlat16_14.xyz = vec3(u_xlat16_27) * u_xlat16_14.xyz + u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_14.xyz;
    u_xlat4 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = max(u_xlat4, 0.00100000005);
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat4);
    u_xlat4 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat5.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat8 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16 = max(u_xlat4, 0.319999993);
    u_xlat16 = u_xlat16_24 * u_xlat16;
    u_xlat16_24 = u_xlat16_25 * u_xlat16_25 + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_24 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat16;
    u_xlat0.x = u_xlat16_25 / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat0.xzw = u_xlat16_7.xyz * u_xlat0.xxx;
    u_xlat0.xzw = u_xlat16_1.xyz * vec3(u_xlat16_6) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat8) + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
    u_xlat24 = vs_TEXCOORD4;
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
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
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
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "_REFLECTIONPROBETYPE_YES" }
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "_REFLECTIONPROBETYPE_YES" }
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "_REFLECTIONPROBETYPE_YES" }
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
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
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
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
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
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" }
  ZWrite Off
  GpuProgramID 66508
Program "vp" {
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_NO" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
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
mediump vec2 u_xlat16_10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat1.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat15) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_10.xy = texture(_MSA, vs_TEXCOORD0.zw).xy;
    u_xlat0.y = (-u_xlat16_10.y) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
    u_xlat16_4.xyz = u_xlat16_10.xxx * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_17 = (-u_xlat16_10.x) * 0.779083729 + 0.779083729;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * vec3(u_xlat16_17) + u_xlat16_4.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat9;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_15;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat12 = max(u_xlat12, 0.319999993);
    u_xlat16_1.xy = texture(_MSA, vs_TEXCOORD0.zw).xy;
    u_xlat16_5.x = (-u_xlat16_1.y) + 1.0;
    u_xlat16_9 = u_xlat16_5.x * u_xlat16_5.x + 1.5;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat12 = u_xlat12 * u_xlat16_9;
    u_xlat9 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_8 = u_xlat16_5.x * u_xlat16_5.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_8 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = u_xlat16_5.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_5.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_15 = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat0.xzw = u_xlat16_5.xyz * vec3(u_xlat16_15) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xzw;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat9;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_15;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat12 = max(u_xlat12, 0.319999993);
    u_xlat16_1.xy = texture(_MSA, vs_TEXCOORD0.zw).xy;
    u_xlat16_5.x = (-u_xlat16_1.y) + 1.0;
    u_xlat16_9 = u_xlat16_5.x * u_xlat16_5.x + 1.5;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat12 = u_xlat12 * u_xlat16_9;
    u_xlat9 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_8 = u_xlat16_5.x * u_xlat16_5.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_8 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = u_xlat16_5.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_5.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_15 = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat0.xzw = u_xlat16_5.xyz * vec3(u_xlat16_15) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xzw;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
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
mediump vec2 u_xlat16_10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat1.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat15) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_10.xy = texture(_MSA, vs_TEXCOORD0.zw).xy;
    u_xlat0.y = (-u_xlat16_10.y) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
    u_xlat16_4.xyz = u_xlat16_10.xxx * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_17 = (-u_xlat16_10.x) * 0.779083729 + 0.779083729;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * vec3(u_xlat16_17) + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat9;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_15;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat12 = max(u_xlat12, 0.319999993);
    u_xlat16_1.xy = texture(_MSA, vs_TEXCOORD0.zw).xy;
    u_xlat16_5.x = (-u_xlat16_1.y) + 1.0;
    u_xlat16_9 = u_xlat16_5.x * u_xlat16_5.x + 1.5;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat12 = u_xlat12 * u_xlat16_9;
    u_xlat9 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_8 = u_xlat16_5.x * u_xlat16_5.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_8 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = u_xlat16_5.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_5.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_15 = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat0.xzw = u_xlat16_5.xyz * vec3(u_xlat16_15) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xzw;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
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
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat9;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_15;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat12 = max(u_xlat12, 0.319999993);
    u_xlat16_1.xy = texture(_MSA, vs_TEXCOORD0.zw).xy;
    u_xlat16_5.x = (-u_xlat16_1.y) + 1.0;
    u_xlat16_9 = u_xlat16_5.x * u_xlat16_5.x + 1.5;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat12 = u_xlat12 * u_xlat16_9;
    u_xlat9 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_8 = u_xlat16_5.x * u_xlat16_5.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_8 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = u_xlat16_5.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_5.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_15 = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat0.xzw = u_xlat16_5.xyz * vec3(u_xlat16_15) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xzw;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD5;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec2 u_xlat16_10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat1.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat15) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_10.xy = texture(_MSA, vs_TEXCOORD0.zw).xy;
    u_xlat0.y = (-u_xlat16_10.y) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
    u_xlat16_4.xyz = u_xlat16_10.xxx * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_17 = (-u_xlat16_10.x) * 0.779083729 + 0.779083729;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * vec3(u_xlat16_17) + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    u_xlat0.x = vs_TEXCOORD5;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD5;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat9;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_15;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat12 = max(u_xlat12, 0.319999993);
    u_xlat16_1.xy = texture(_MSA, vs_TEXCOORD0.zw).xy;
    u_xlat16_5.x = (-u_xlat16_1.y) + 1.0;
    u_xlat16_9 = u_xlat16_5.x * u_xlat16_5.x + 1.5;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat12 = u_xlat12 * u_xlat16_9;
    u_xlat9 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_8 = u_xlat16_5.x * u_xlat16_5.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_8 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = u_xlat16_5.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_5.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_15 = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat0.xzw = u_xlat16_5.xyz * vec3(u_xlat16_15) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xzw;
    u_xlat12 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD5;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat9;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_15;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat12 = max(u_xlat12, 0.319999993);
    u_xlat16_1.xy = texture(_MSA, vs_TEXCOORD0.zw).xy;
    u_xlat16_5.x = (-u_xlat16_1.y) + 1.0;
    u_xlat16_9 = u_xlat16_5.x * u_xlat16_5.x + 1.5;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat12 = u_xlat12 * u_xlat16_9;
    u_xlat9 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_8 = u_xlat16_5.x * u_xlat16_5.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_8 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = u_xlat16_5.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_5.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_15 = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat0.xzw = u_xlat16_5.xyz * vec3(u_xlat16_15) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xzw;
    u_xlat12 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD5;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
uniform highp sampler2D unity_NHxRoughness;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec2 u_xlat16_10;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat1.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat15) * _LightColor0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_10.xy = texture(_MSA, vs_TEXCOORD0.zw).xy;
    u_xlat0.y = (-u_xlat16_10.y) + 1.0;
    u_xlat0.x = texture(unity_NHxRoughness, u_xlat0.xy).x;
    u_xlat0.x = u_xlat0.x * 16.0;
    u_xlat16_1.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.xyz;
    u_xlat16_4.xyz = u_xlat16_10.xxx * u_xlat16_4.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_17 = (-u_xlat16_10.x) * 0.779083729 + 0.779083729;
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * vec3(u_xlat16_17) + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    u_xlat0.x = vs_TEXCOORD5;
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
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD5;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat9;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_15;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat12 = max(u_xlat12, 0.319999993);
    u_xlat16_1.xy = texture(_MSA, vs_TEXCOORD0.zw).xy;
    u_xlat16_5.x = (-u_xlat16_1.y) + 1.0;
    u_xlat16_9 = u_xlat16_5.x * u_xlat16_5.x + 1.5;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat12 = u_xlat12 * u_xlat16_9;
    u_xlat9 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_8 = u_xlat16_5.x * u_xlat16_5.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_8 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = u_xlat16_5.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_5.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_15 = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat0.xzw = u_xlat16_5.xyz * vec3(u_xlat16_15) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xzw;
    u_xlat12 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _MSA_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD5;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _MSA_ST.xy + _MSA_ST.zw;
    u_xlat16_2 = (-unity_FogColor.w) + 1.0;
    vs_TEXCOORD5 = max(u_xlat0.x, u_xlat16_2);
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
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform mediump sampler2D _MainTex;
uniform mediump sampler2D _MSA;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_8;
float u_xlat9;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_15;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12) + _WorldSpaceLightPos0.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat12 = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat12 = max(u_xlat12, 0.319999993);
    u_xlat16_1.xy = texture(_MSA, vs_TEXCOORD0.zw).xy;
    u_xlat16_5.x = (-u_xlat16_1.y) + 1.0;
    u_xlat16_9 = u_xlat16_5.x * u_xlat16_5.x + 1.5;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat12 = u_xlat12 * u_xlat16_9;
    u_xlat9 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_8 = u_xlat16_5.x * u_xlat16_5.x + -1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_8 + 1.00001001;
    u_xlat0.x = u_xlat0.x * u_xlat12;
    u_xlat0.x = u_xlat16_5.x / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -9.99999975e-05;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = min(u_xlat0.x, 100.0);
    u_xlat16_5.xyz = vs_COLOR0.xyz * _Color.xyz;
    u_xlat16_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
    u_xlat16_5.xyz = u_xlat16_5.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
    u_xlat16_15 = (-u_xlat16_1.x) * 0.779083729 + 0.779083729;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat0.xzw = u_xlat16_5.xyz * vec3(u_xlat16_15) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat0.xzw * _LightColor0.xyz;
    u_xlat0.xyz = vec3(u_xlat4) * u_xlat0.xzw;
    u_xlat12 = vs_TEXCOORD5;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat12);
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
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "_REFLECTIONPROBETYPE_YES" }
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
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "_REFLECTIONPROBETYPE_YES" }
""
}
}
}
}
Fallback "Booster/Black"
}